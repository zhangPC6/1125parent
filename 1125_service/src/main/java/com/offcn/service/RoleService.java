package com.offcn.service;

import com.offcn.bean.Role;
import com.offcn.bean.RoleSources;

import java.util.List;
import java.util.Map;

public interface RoleService {
    boolean addRole(Role role, Integer[] ids);

    List<Role> getAllRole();

    Map<String, Object> getOneRoleByPk(Integer roleid);

    boolean deleteRoleByPk(Integer[] ids);
}
