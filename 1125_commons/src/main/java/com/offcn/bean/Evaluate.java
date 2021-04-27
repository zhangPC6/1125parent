package com.offcn.bean;

import java.io.Serializable;
import java.util.Date;

public class Evaluate  implements Serializable {
    private Integer evaid;

    private Integer forumFk;

    private Integer empFk;

    private Integer evaidFk;

    private String evacontent;

    private Date updatetime;

    public Integer getEvaid() {
        return evaid;
    }

    public void setEvaid(Integer evaid) {
        this.evaid = evaid;
    }

    public Integer getForumFk() {
        return forumFk;
    }

    public void setForumFk(Integer forumFk) {
        this.forumFk = forumFk;
    }

    public Integer getEmpFk() {
        return empFk;
    }

    public void setEmpFk(Integer empFk) {
        this.empFk = empFk;
    }

    public Integer getEvaidFk() {
        return evaidFk;
    }

    public void setEvaidFk(Integer evaidFk) {
        this.evaidFk = evaidFk;
    }

    public String getEvacontent() {
        return evacontent;
    }

    public void setEvacontent(String evacontent) {
        this.evacontent = evacontent == null ? null : evacontent.trim();
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }
}