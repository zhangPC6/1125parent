package com.offcn.service;

import com.offcn.bean.Role;
import com.offcn.bean.Sources;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PrivilegeService {

    public Sources getRootAndChildrenSources();

    List<Sources> getSecondLevel();

    Sources getOneSourceById(Integer id);

    boolean updateSources(Sources sources);

    boolean deleteSourcesById(Integer[] id);

    boolean addRole(Role role, Integer[] ids);
}
