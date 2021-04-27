package com.offcn.service;

import com.offcn.bean.Dept;

import java.util.List;

public interface DeptService {
    List<Dept> showDept();

    boolean batchAddInfo(List<Dept> list);

    boolean addOneDept(Dept dept);
}
