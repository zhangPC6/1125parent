package com.offcn.service;

import com.offcn.bean.EmpRole;
import com.offcn.bean.Employee;
import com.offcn.bean.Sources;
import com.offcn.vo.EmployeeVo;

import java.util.List;
import java.util.Map;

public interface EmpService {
    List<Employee> showAllEmp(EmployeeVo employeeVo);

    boolean saveEmpInfo(Employee employee, Integer roleid);

    Employee showEmpByPk(Integer eid);

    boolean updateEmpByPK(Employee employee);

    Employee login(String username, String password);

    EmpRole getEmpRoleInfoByEid(Integer eid);

    Map<String, List<Sources>> getAllRoleAndSourceInfo();
}
