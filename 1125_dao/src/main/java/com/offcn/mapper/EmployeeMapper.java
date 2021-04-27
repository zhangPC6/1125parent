package com.offcn.mapper;


import com.offcn.bean.Employee;
import com.offcn.vo.EmployeeVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {

    int saveEmpInfo(Employee employee);

    List<Employee> showEmpInfo(EmployeeVo employeeVo);

    Employee showEmpByPk(@Param("eid") Integer eid);

    int updateEmpByPK(Employee employee);

    Employee login(@Param("uname") String username, @Param("pwd") String encodeByMD5);
}