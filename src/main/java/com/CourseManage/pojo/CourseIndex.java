package com.CourseManage.pojo;

public class CourseIndex {
    private Integer id;

    private Integer courseResid;

    private Integer chapter;

    private String chaprtTitle;

    private Integer part;

    private String partTitle;

    private Integer courseid;

    private String type;

    private Integer video;

    private Integer word;

    private Integer pdf;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCourseResid() {
        return courseResid;
    }

    public void setCourseResid(Integer courseResid) {
        this.courseResid = courseResid;
    }

    public Integer getChapter() {
        return chapter;
    }

    public void setChapter(Integer chapter) {
        this.chapter = chapter;
    }

    public String getChaprtTitle() {
        return chaprtTitle;
    }

    public void setChaprtTitle(String chaprtTitle) {
        this.chaprtTitle = chaprtTitle == null ? null : chaprtTitle.trim();
    }

    public Integer getPart() {
        return part;
    }

    public void setPart(Integer part) {
        this.part = part;
    }

    public String getPartTitle() {
        return partTitle;
    }

    public void setPartTitle(String partTitle) {
        this.partTitle = partTitle == null ? null : partTitle.trim();
    }

    public Integer getCourseid() {
        return courseid;
    }

    public void setCourseid(Integer courseid) {
        this.courseid = courseid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Integer getVideo() {
        return video;
    }

    public void setVideo(Integer video) {
        this.video = video;
    }

    public Integer getWord() {
        return word;
    }

    public void setWord(Integer word) {
        this.word = word;
    }

    public Integer getPdf() {
        return pdf;
    }

    public void setPdf(Integer pdf) {
        this.pdf = pdf;
    }
}