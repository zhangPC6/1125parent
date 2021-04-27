package com.offcn.mapper;


import com.offcn.bean.Sources;
import com.offcn.util.SelectMark;
import org.apache.ibatis.annotations.Param;

import javax.xml.transform.Source;
import java.util.List;

public interface SourcesMapper {

    List<Sources> getInfoByEid(SelectMark selectMark);

    //获取资源的根节点
    public Sources getRootSources();

    //根据父节点的pid获取子节点的菜单
    public List<Sources> getChildren(@Param("pid") Integer pid);

    Sources selectByPrimaryKey(@Param("id") Integer id);

    int updateSources(Sources sources);

    int insertSources(Sources sources);

    int deleteSourcesById(@Param("id") Integer[] id);

    List<Source> getSourcesByRoleid(@Param("roleid") Integer roleid);
}