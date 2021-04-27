package com.offcn.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.bean.Role;
import com.offcn.service.RoleService;
import com.offcn.util.ConstMessage;
import com.offcn.util.ResultMsg;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class RoleController {

    boolean flag;
    @Resource
    private RoleService roleService;


    //addRole
    @RequestMapping("addRole")
    public String addRole(Role role, Integer[] ids) {
        flag = roleService.addRole(role, ids);
        if (flag){
            return "redirect:/showAllRole";
        }else {
            return "redirect:/500.html";
        }
    }

    @RequestMapping("/showAllRole")
    public String showAllRole(@RequestParam(name = "pageNum",defaultValue = "1") Integer pageNum, ModelMap modelMap) {
        PageHelper.startPage(pageNum,3);
        List<Role> roleList = roleService.getAllRole();
        PageInfo<Role> pageInfo = new PageInfo<>(roleList);
        modelMap.put("pageInfo",pageInfo);
        return "list-role";
    }

    @RequestMapping("/getOneRoleByPk")
    @ResponseBody
    public Map<String,Object> getOneRoleByPk(Integer roleid) {
        return roleService.getOneRoleByPk(roleid);
    }

    @RequestMapping("/deleteRoleByPk")
    @ResponseBody
    public ResultMsg deleteRoleByPk(Integer[] ids) {
        flag = roleService.deleteRoleByPk(ids);
        if(flag){
            return new ResultMsg(true, ConstMessage.PROMETION_DELETE_SUCCESS);
        }else {
            return new ResultMsg(true, ConstMessage.PROMETION_DELETE_FAIL);
        }
    }


    //getAllRole
    @RequestMapping("/getAllRole")
    @ResponseBody
    public List<Role> getAllRole() {
        return roleService.getAllRole();
    }



}
