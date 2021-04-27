package com.offcn.service;

import com.offcn.bean.EmpRole;
import com.offcn.bean.Employee;
import com.offcn.bean.Role;
import com.offcn.bean.Sources;
import com.offcn.mapper.EmpRoleMapper;
import com.offcn.mapper.EmployeeMapper;
import com.offcn.mapper.RoleMapper;
import com.offcn.mapper.SourcesMapper;
import com.offcn.util.SelectMark;
import com.offcn.vo.EmployeeVo;
import org.springframework.stereotype.Service;
import com.offcn.util.Md5;
import org.springframework.transaction.annotation.Transactional;
import sun.security.provider.MD5;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EmpServiceImpl implements EmpService {

    boolean flag;

    @Resource
    private EmployeeMapper employeeMapper;

    @Resource
    private EmpRoleMapper empRoleMapper;

    @Resource
    private RoleMapper roleMapper;
    @Resource
    private SourcesMapper sourcesMapper;

    @Override
    public List<Employee> showAllEmp(EmployeeVo employeeVo) {
        return employeeMapper.showEmpInfo(employeeVo);
    }

    @Override
    public Map<String, List<Sources>> getAllRoleAndSourceInfo() {
        Map<String, List<Sources>> listMap = new HashMap<>();
        List<Role> roleList =  roleMapper.showRoleInfo();
        for (Role role:roleList){
            SelectMark selectMark = new SelectMark(1, null, null, role.getRoleid());
            //登陆成功显示模块名称的级别资源
            List<Sources> sourcesList = sourcesMapper.getInfoByEid(selectMark);
            for (Sources parents:sourcesList){
                //根据角色id 模板资源id 进行联合查询
                SelectMark selectMark1 = new SelectMark(2, null, parents.getPid(), role.getRoleid());
                List<Sources> sourcesList1 = sourcesMapper.getInfoByEid(selectMark1);
                parents.setChildren(sourcesList1);
            }
            listMap.put(role.getRoleid()+"", sourcesList);
        }

        return listMap;
    }

    @Override
    public EmpRole getEmpRoleInfoByEid(Integer eid) {
        return empRoleMapper.getEmpRoleInfoByEid(eid);
    }

    @Override
    public Employee login(String username, String password) {
        return employeeMapper.login(username, Md5.encodeByMD5(password));
    }

    @Override
    @Transactional
    public boolean saveEmpInfo(Employee employee, Integer roleid) {
        /*
        * 保存员工信息表
        * 员工角色中间表
        * */
        employee.setPassword(Md5.encodeByMD5(employee.getPassword()));
        flag = employeeMapper.saveEmpInfo(employee) > 0;
        //保存员工角色中间表
        EmpRole empRole = new EmpRole();
        empRole.setEmpFk(employee.getEid());
        empRole.setRoleFk(roleid);
        flag = empRoleMapper.saveEmpRole(empRole) > 0;
        return flag;
    }

    @Override
    public Employee showEmpByPk(Integer eid) {
        return employeeMapper.showEmpByPk(eid);
    }

    @Override
    public boolean updateEmpByPK(Employee employee) {
        return employeeMapper.updateEmpByPK(employee) > 0;
    }
}
