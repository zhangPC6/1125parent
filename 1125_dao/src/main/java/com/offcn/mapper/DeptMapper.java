package com.offcn.mapper;

import com.offcn.bean.Dept;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeptMapper {


    List<Dept> showDept();

    Dept getDeptByPk(@Param("pk") Integer pk);

    int batchAddInfo(List<Dept> list);

    int addOneDept(Dept dept);
}