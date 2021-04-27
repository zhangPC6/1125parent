package com.offcn.util;

public class SelectMark {
    private Integer mark;
    private Integer eid;
    private Integer pid;
    private Integer roleid;

    public SelectMark() {
    }

    public SelectMark(Integer mark, Integer eid, Integer pid, Integer roleid) {
        this.mark = mark;
        this.eid = eid;
        this.pid = pid;
        this.roleid = roleid;
    }

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public Integer getMark() {
        return mark;
    }

    public void setMark(Integer mark) {
        this.mark = mark;
    }

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }
}
