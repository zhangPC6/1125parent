package com.offcn.service;

import com.offcn.bean.Role;
import com.offcn.bean.RoleSources;
import com.offcn.bean.Sources;
import com.offcn.mapper.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class PrivilegeServiceImpl implements PrivilegeService {

    boolean flag;

    @Resource
    private SourcesMapper sourcesMapper;

    @Resource
    private RoleSourcesMapper roleSourcesMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private DeptMapper deptMapper;

    @Resource
    private EmployeeMapper employeeMapper;

    @Resource
    private EmpRoleMapper empRoleMapper;

    @Override
    public Sources getRootAndChildrenSources() {
        Sources rootSources = sourcesMapper.getRootSources();
        rootSources.setOpen(true);
        getChild(rootSources);
        return rootSources;
    }

    @Override
    public List<Sources> getSecondLevel() {
        return sourcesMapper.getChildren(1);
    }

    //递归获取父节点的子节点
    public void getChild(Sources sources){
        List<Sources> children = sourcesMapper.getChildren(sources.getId());
        if (children.size() > 0){
            sources.setChildren(children);
            for (Sources sources1: children){
                getChild(sources1);
            }
        }
    }

    //通过id获取资源getOneSourceById
    @Override
    public Sources getOneSourceById(Integer id) {
        return sourcesMapper.selectByPrimaryKey(id);
    }

    @Override
    public boolean updateSources(Sources sources) {
        if (sources.getId() != null){
            flag = sourcesMapper.updateSources(sources) > 0;
        }else {
            flag = sourcesMapper.insertSources(sources) > 0;
        }
        return flag;
    }

    @Override
    public boolean deleteSourcesById(Integer[] id) {
        //角色资源表关联资源表 先删除角色资源表
        flag = roleSourcesMapper.deleteRoleSourcesById(id) > 0;
        //删除资源表内容
        flag =sourcesMapper.deleteSourcesById(id) > 0;
        return flag;
    }

    @Override
    public boolean addRole(Role role, Integer[] ids) {
        //角色表 角色资源表
        flag = roleMapper.addRole(role) > 0;
        //批量添加角色资源表
        List<RoleSources> roleSourcesList = new ArrayList<>();
        for (Integer id: ids){
            RoleSources roleSources = new RoleSources();
            roleSources.setResourcesFk(id);
            roleSources.setRoleFk(role.getRoleid());
            roleSources.setRsdis(role.getRolename() + "有" + id + "号资源");
            roleSourcesList.add(roleSources);
        }
        flag = roleSourcesMapper.batchAddInfo(roleSourcesList) > 0;
        return flag;
    }
}
