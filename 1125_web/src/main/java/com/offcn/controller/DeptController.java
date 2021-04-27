package com.offcn.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.bean.Dept;
import com.offcn.service.DeptService;
import com.offcn.util.LayuiResponseBody;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class DeptController {

    boolean flag;

    @Resource
    private DeptService deptService;

    @RequestMapping("/showDept")
    @ResponseBody
    public LayuiResponseBody showDept(@RequestParam(name = "page", defaultValue = "1") Integer page
            , @RequestParam(name = "limit", defaultValue = "2")Integer limit) {
        PageHelper.startPage(page,limit);
        List<Dept> deptList =  deptService.showDept();
        PageInfo<Dept> pageInfo = new PageInfo<>(deptList);
        return new LayuiResponseBody(0,"",pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/getAllDept")
    @ResponseBody
    public List<Dept> getAllDept() {
        return deptService.showDept();
    }

    @RequestMapping("/addOneDept")
    public String addOneDept(Dept dept) {
        flag = deptService.addOneDept(dept);
        if(flag){
            return "list-dept";
        }else {
            return "redirect:/500.html";
        }

    }
}
