package com.offcn.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.bean.Role;
import com.offcn.bean.Sources;
import com.offcn.service.PrivilegeService;
import com.offcn.util.ConstMessage;
import com.offcn.util.ResultMsg;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
//@RequestMapping("privilege")
public class Privilegecontroller {

    boolean flag;
    @Resource
    private PrivilegeService privilegeService;

    @RequestMapping("showTree")
    @ResponseBody
    public Sources showTree(){
        /*//我们需要使用我们查询的车的内容获取车的详情信息并且分页显式
        PageHelper.startPage(pageNum, 2);
        List<Cardetail> list = shoopService.getCarDetailByCid(one.getCid());
        PageInfo<Cardetail> pageInfo = new PageInfo<>(list);
        modelMap.put("pageInfo", pageInfo);
        modelMap.addAttribute("car", one);*/
        return privilegeService.getRootAndChildrenSources();
    }

    //getSecondLevel
    @RequestMapping("getSecondLevel")
    @ResponseBody
    public List<Sources> getSecondLevel(){
        return privilegeService.getSecondLevel();
    }

    //getOneSourceById
    @RequestMapping("getOneSourceById")
    @ResponseBody
    public Sources getOneSourceById(Integer id){
        return  privilegeService.getOneSourceById(id);
    }

    //updateSources
    @RequestMapping("updateSources")
    public String updateSources(Sources sources){
        flag = privilegeService.updateSources(sources);
        if (flag) {
            return "list-resources";
        }else {
            return "redirect:/500.html";
        }
    }

    //deleteSourcesById
    @RequestMapping("deleteSourcesById")
    @ResponseBody
    public ResultMsg deleteSourcesById(Integer[] id){
        flag = privilegeService.deleteSourcesById(id);
        if (flag) {
            return new ResultMsg(true, ConstMessage.PROMETION_DELETE_SUCCESS);
        }else {
            return new ResultMsg(false,ConstMessage.PROMETION_DELETE_FAIL);
        }
    }
}
