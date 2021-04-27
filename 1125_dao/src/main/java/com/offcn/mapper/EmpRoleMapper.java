package com.offcn.mapper;


import com.offcn.bean.EmpRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmpRoleMapper {

    int saveEmpRole(EmpRole empRole);

    List<EmpRole> getInfoByRoleid(@Param("ids") Integer[] ids);

    EmpRole getEmpRoleInfoByEid(@Param("eid") Integer eid);
}