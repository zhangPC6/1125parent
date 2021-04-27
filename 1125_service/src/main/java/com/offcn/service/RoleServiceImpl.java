package com.offcn.service;

import com.offcn.bean.EmpRole;
import com.offcn.bean.Role;
import com.offcn.bean.RoleSources;
import com.offcn.mapper.EmpRoleMapper;
import com.offcn.mapper.RoleMapper;
import com.offcn.mapper.RoleSourcesMapper;
import com.offcn.mapper.SourcesMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.xml.transform.Source;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    boolean flag;
    @Resource
    private RoleMapper        roleMapper;
    @Resource
    private RoleSourcesMapper roleSourcesMapper;
    @Resource
    private SourcesMapper sourcesMapper;
    @Resource
    private EmpRoleMapper empRoleMapper;

    @Override
    @Transactional
    public boolean addRole(Role role, Integer[] ids) {

        /*
         * 1: 添加角色信息到角色表中
         * 2: 将我们的角色和资源表中添加本次创建的角色对应的资源数据
         *    添加过程中需要使用到刚才在角色表中添加的数据主键值
         * */
        if(role.getRoleid()!=null){
            /*
            * id存在更新角色权限，先删除原权限，在更新
            * */
            flag = roleMapper.updateRoleByRoleid(role) > 0;
            Integer[] nids = {role.getRoleid()};
            flag = roleSourcesMapper.deleteRoleSourcesById(nids) > 0;
        }else {
            flag = roleMapper.addRole(role)>0;
        }
        //批量添加角色和资源的中间表数据
        List<RoleSources> list =new ArrayList<>();
        for(Integer id:ids){
            RoleSources roleSources = new RoleSources();
            roleSources.setRoleFk(role.getRoleid());
            roleSources.setResourcesFk(id);
            roleSources.setRsdis(role.getRolename()+"有"+id+"号资源");
            list.add(roleSources);
        }
        flag = roleSourcesMapper.batchAddInfo(list)>0;

        return flag;
    }

    @Override
    public List<Role> getAllRole() {
        return  roleMapper.selectAllRole();
    }

    @Override
    public Map<String, Object> getOneRoleByPk(Integer roleid) {
        Map<String,Object> map = new HashMap<>();
        Role role = roleMapper.selectByPrimaryKey(roleid);
        map.put("role", role);
        List<Source> sourceList = sourcesMapper.getSourcesByRoleid(roleid);
        map.put("sourceList",sourceList);
        return map;
    }

    @Override
    @Transactional
    public boolean deleteRoleByPk(Integer[] ids) {
        /*
        * 删除角色 需要验证当前角色是否已经被员工使用，分配的不能删除
        * 删除角色资源中间表、删除角色表
        * */
        List<EmpRole> empRoles = empRoleMapper.getInfoByRoleid(ids);
        if (empRoles.size() > 0){
            return flag;
        }else {
            flag = roleSourcesMapper.deleteRoleSourcesByRoleid(ids) > 0;
            flag = roleMapper.deleteRoleByPk(ids) > 0;
        }
        return flag;
    }


}
