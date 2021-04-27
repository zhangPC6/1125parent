package com.offcn.vo;

import com.offcn.bean.Employee;

//业务模型对象
public class EmployeeVo extends Employee {
    private  String  keyCode;
    private  Integer  searchType;

    public String getKeyCode() {
        return keyCode;
    }

    public void setKeyCode(String keyCode) {
        this.keyCode = keyCode;
    }

    public Integer getSearchType() {
        return searchType;
    }

    public void setSearchType(Integer searchType) {
        this.searchType = searchType;
    }
}
