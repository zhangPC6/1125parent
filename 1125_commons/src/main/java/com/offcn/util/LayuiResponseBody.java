package com.offcn.util;

import com.offcn.bean.Dept;

import java.util.List;

public class LayuiResponseBody {

    private Integer code;
    private String msg;
    private Long count;
    private List<Dept> data;

    public LayuiResponseBody() {
    }

    public LayuiResponseBody(Integer code, String msg, Long count, List<Dept> data) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public List<Dept> getData() {
        return data;
    }

    public void setData(List<Dept> data) {
        this.data = data;
    }
}
