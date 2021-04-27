package com.offcn.service;

import com.offcn.bean.Dept;
import com.offcn.mapper.DeptMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DeptServiceImpl implements  DeptService {

    @Resource
    private DeptMapper deptMapper;

    @Override
    public List<Dept> showDept() {
        return deptMapper.showDept();
    }

    @Override
    @Transactional
    public boolean batchAddInfo(List<Dept> list) {
        return deptMapper.batchAddInfo(list) > 0;
    }

    @Override
    public boolean addOneDept(Dept dept) {
        return deptMapper.addOneDept(dept) > 0;
    }
}
