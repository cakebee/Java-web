package com.MessageManage.pojo;

import java.util.Date;

public class Message {
    private Integer id;
    //消息发送方id
    private String sendid;
    //消息接收方id
    private String receid;
    //消息主体内容
    private String content;
    //消息发送时间
    private Date sendtime;
    //消息是否已读
    private Byte flag;
    //消息标题
    private String title;
    //接收方是否已删除该消息
    private Byte receiver;
    //发送方是否已删除该消息
    private Byte sender;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSendid() {
        return sendid;
    }

    public void setSendid(String sendid) {
        this.sendid = sendid == null ? null : sendid.trim();
    }

    public String getReceid() {
        return receid;
    }

    public void setReceid(String receid) {
        this.receid = receid == null ? null : receid.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Date getSendtime() {
        return sendtime;
    }

    public void setSendtime(Date sendtime) {
        this.sendtime = sendtime;
    }

    public Byte getFlag() {
        return flag;
    }

    public void setFlag(Byte flag) {
        this.flag = flag;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Byte getReceiver() {
        return receiver;
    }

    public void setReceiver(Byte receiver) {
        this.receiver = receiver;
    }

    public Byte getSender() {
        return sender;
    }

    public void setSender(Byte sender) {
        this.sender = sender;
    }
}