package com.UserManage.pojo;

public class Tag {
    private Integer id;

    private String tag;

    private Integer citednum;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag == null ? null : tag.trim();
    }

    public Integer getCitednum() {
        return citednum;
    }

    public void setCitednum(Integer citednum) {
        this.citednum = citednum;
    }
}