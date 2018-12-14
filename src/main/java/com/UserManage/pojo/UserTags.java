package com.UserManage.pojo;

public class UserTags {
    private Integer id;

    private String userid;

    private Integer tagid;

    private String tagcontent;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid == null ? null : userid.trim();
    }

    public Integer getTagid() {
        return tagid;
    }

    public void setTagid(Integer tagid) {
        this.tagid = tagid;
    }

    public String getTagcontent() {
        return tagcontent;
    }

    public void setTagcontent(String tagcontent) {
        this.tagcontent = tagcontent == null ? null : tagcontent.trim();
    }
}