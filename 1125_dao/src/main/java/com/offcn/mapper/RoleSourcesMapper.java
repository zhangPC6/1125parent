package com.offcn.mapper;


import com.offcn.bean.RoleSources;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleSourcesMapper {

    int deleteRoleSourcesById(@Param("id") Integer[] id);

    int batchAddInfo(List<RoleSources> roleSourcesList);

    List<RoleSources> selectByPrimaryKey();

    int deleteRoleSourcesByRoleid(Integer[] ids);
}