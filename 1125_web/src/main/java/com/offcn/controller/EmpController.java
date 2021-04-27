package com.offcn.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.bean.Dept;
import com.offcn.bean.EmpRole;
import com.offcn.bean.Employee;

import com.offcn.bean.Sources;
import com.offcn.service.DeptService;
import com.offcn.service.EmpService;
import com.offcn.util.ObjectToMap;
import com.offcn.vo.EmployeeVo;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class EmpController {

    boolean flag;

    @Resource
    private EmpService empService;

    @Resource
    private DeptService deptService;

    @Resource
    private JedisPool jedisPool;
    //updateEmpByPK
    @RequestMapping("/updateEmpByPK")
    public String updateEmpByPK(Employee employee) {
       flag = empService.updateEmpByPK(employee);
        if (flag){
            return "redirect:/showAllEmp";
        }else {
            return "500.html";
        }
    }

    //showEmpByPk
    @RequestMapping("/showEmpByPk")
    public String showEmpByPk( Integer eid,ModelMap modelMap) {
        Employee employee = empService.showEmpByPk(eid);
        modelMap.addAttribute("emp",employee);
        if (employee != null){
            return "show-employee";
        }else {
            return "500.html";
        }
    }
    //登录操作
    @RequestMapping("/login")
    public String login(String username,String password,HttpSession session) throws Exception {
        /*
         * 盐值加密
         * 同一个平台2个账号密码 123456
         * (不同用户名+123456)
         * */
        Employee employee = empService.login(username,password);
        if(employee!=null){
            //使用redis 存放我们的登录对象,使用redis hash类型
            Jedis jedis = jedisPool.getResource();
            jedis.hmset("activeUser",ObjectToMap.objToMap(employee));
            session.setAttribute("activeUser",employee);
            //通过登录用户获取角色id
            EmpRole empRole = empService.getEmpRoleInfoByEid(employee.getEid());
            //用户对应的角色的id 充当redis中存放数据key
            String sourcesJson = jedis.get(empRole.getRoleFk()+"");
            List<Sources> sources = null;
            if(sourcesJson!=null && sourcesJson.length()>0){
                //使用阿里巴巴的fastjson 工具完成数据的转换
                sources = JSON.parseArray(sourcesJson, Sources.class);
            }else{
                //查询所有的角色以及角色对应的层级资源List<Sources>,
                //使用角色的id值 key  使用角色对应的List<Sources> value
                Map<String,List<Sources>> map = empService.getAllRoleAndSourceInfo();
                //将我们的角色和角色对应的资源放入到redis中
                for(Map.Entry<String,List<Sources>> entry: map.entrySet()){
                    //key  角色id   value  阿里巴巴的fastjson工具 List<Sources> --- String(json)
                    jedis.set(entry.getKey(),JSON.toJSONString(entry.getValue()));
                    //给当前第一次登陆的用户的资源集合赋值
                    if((empRole.getRoleFk()+"").equals(entry.getKey())){
                        sources=entry.getValue();
                    }
                }
            }
            //获取我们登录用户的角色信息-当前登录用户对应的资源信息
            session.setAttribute("sources",sources);
            return  "redirect:/index.jsp";
        }else{
            return "redirect:/login.jsp";
        }
    }

    @RequestMapping("/showAllEmp")
    public String showAllEmp(@RequestParam(name = "mark",defaultValue = "1") Integer mark,
                             @RequestParam(name = "pageNum",defaultValue = "1") Integer pageNum,
                             EmployeeVo employeeVo, ModelMap modelMap, HttpSession session) {
        if(mark==3 ||(employeeVo.getKeyCode()!=null && employeeVo.getKeyCode().length()>0)){
            session.removeAttribute("ck");
        }
        //session 作用就是分页的值的存储
        PageHelper.startPage(pageNum,3);
        EmployeeVo vo = (EmployeeVo)session.getAttribute("ck");
        List<Employee> list = null;
        if(vo!=null){
            list = empService.showAllEmp(vo);
        }else{
            list = empService.showAllEmp(employeeVo);
            session.setAttribute("ck",employeeVo);
        }
        PageInfo<Employee> employeePageInfo = new PageInfo<Employee>(list);
        session.setAttribute("emps",employeePageInfo.getList());
        modelMap.addAttribute("pageInfo",employeePageInfo);
        return  "list-employee";
    }

    @RequestMapping("/saveEmpInfo")
    public String saveEmpInfo(Employee employee, Integer roleid) {
        flag = empService.saveEmpInfo(employee,roleid);
        if (flag){
            return "redirect:/showAllEmp";
        }else {
            return "500.html";
        }
    }

    //outPutExcel
    @RequestMapping("/outPutExcel")
    public String outPutExcel(HttpSession session, String filename) throws Exception {
        //获取导出数据的内容
        List<Employee> list = (List<Employee>)session.getAttribute("emps");
        //使用poi工具类完成数据导出
        HSSFWorkbook workbook = new HSSFWorkbook();
        //创建sheet页
        HSSFSheet sheet1 = workbook.createSheet("学员信息");
        //创建sheet页表头
        HSSFRow row0 = sheet1.createRow(0);
        //创建多个单元格
        HSSFCell cell0 = row0.createCell(0);
        cell0.setCellValue("姓名");
        HSSFCell cell1 = row0.createCell(1);
        cell0.setCellValue("职位");
        HSSFCell cell2 = row0.createCell(2);
        cell0.setCellValue("性别");
        HSSFCell cell3 = row0.createCell(3);
        cell0.setCellValue("联系电话");
        HSSFCell cell4 = row0.createCell(4);
        cell0.setCellValue("入职时间");
        HSSFCell cell5 = row0.createCell(5);
        cell0.setCellValue("状态");
        for(int i=0;i<list.size();i++){
            Employee employee = list.get(i);
            HSSFRow row1 = sheet1.createRow(i + 1);
            HSSFCell cell6 = row1.createCell(0);
            cell6.setCellValue(employee.getEname());
            HSSFCell cell7 = row1.createCell(1);
            cell7.setCellValue(employee.getDept().getDname());
            HSSFCell cell8 = row1.createCell(2);
            cell8.setCellValue(employee.getEsex());
            HSSFCell cell9 = row1.createCell(3);
            cell9.setCellValue(employee.getTelephone());
            HSSFCell cell10 = row1.createCell(4);
            cell10.setCellValue(employee.getEage());
            HSSFCell cell11 = row1.createCell(5);
            cell11.setCellValue(employee.getHiredate());
            //设置某个单元格的单独的显式样式
            HSSFCellStyle cellStyle = workbook.createCellStyle();
            HSSFDataFormat dataFormat = workbook.createDataFormat();
            cellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));
            cell11.setCellStyle(cellStyle);
        }


        String path ="C:\\Users\\ZhangPC\\Documents\\uploadFile"+filename+".xls";
        File file = new File(path);
        FileOutputStream fos = new FileOutputStream(file);
        workbook.write(fos);
        fos.close();
        return "redirect:/showAllEmp";

    }

    //pio实现excel导入
    @RequestMapping("/inExcel")
    public  String  inExcel(MultipartFile[] files) throws Exception {

        InputStream inputStream = files[0].getInputStream();
        //excel对象
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
        List<Dept> list = null;
        for(int i=0;i<workbook.getNumberOfSheets();i++){
            //根据下标获取sheet
            HSSFSheet sheet = workbook.getSheetAt(i);
            list = new ArrayList<>();
            for(int j=0;j<sheet.getLastRowNum();j++){
                HSSFRow row = sheet.getRow(j + 1);
                Dept  dept = new Dept();
                /*HSSFCell cell0 = row.getCell(0);
                dept.setDeptno((int)cell0.getNumericCellValue());*/
                HSSFCell cell1 = row.getCell(1);
                dept.setDname(cell1.getStringCellValue());
                HSSFCell cell2 = row.getCell(2);
                dept.setLocal(cell2.getStringCellValue());
                list.add(dept);
            }
        }
        boolean  flag  = deptService.batchAddInfo(list);
        return "redirect:/showAllEmp";
    }

}
