package com.UserManage.pojo;

public class UserImage {
    private Integer id;

    private String userid;

    private byte[] userimage;

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

    public byte[] getUserimage() {
        return userimage;
    }

    public void setUserimage(byte[] userimage) {
        this.userimage = userimage;
    }
}