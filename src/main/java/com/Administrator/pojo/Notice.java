package com.Administrator.pojo;

import java.util.Date;

public class Notice {
    private Integer id;

    private String content;

    private String title;

    private Date notitime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Date getNotitime() {
        return notitime;
    }

    public void setNotitime(Date notitime) {
        this.notitime = notitime;
    }
}