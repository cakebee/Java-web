package com.CourseManage.pojo;

import java.util.Date;

public class Answer {
    private Integer id;

    private Integer quesid;

    private String userid;

    private Date answtime;

    private String content;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuesid() {
        return quesid;
    }

    public void setQuesid(Integer quesid) {
        this.quesid = quesid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid == null ? null : userid.trim();
    }

    public Date getAnswtime() {
        return answtime;
    }

    public void setAnswtime(Date answtime) {
        this.answtime = answtime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}