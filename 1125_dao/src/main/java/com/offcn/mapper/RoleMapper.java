package com.offcn.mapper;


import com.offcn.bean.Role;

import java.util.List;

public interface RoleMapper {

    int addRole(Role role);

    Role selectByPrimaryKey(Integer roleid);

    List<Role> selectAllRole();

    int updateRoleByPk(Role role);

    int deleteRoleByPk(Integer[] ids);

    int updateRoleByRoleid(Role role);

    List<Role> showRoleInfo();
}