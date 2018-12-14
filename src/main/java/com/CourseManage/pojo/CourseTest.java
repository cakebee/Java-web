package com.CourseManage.pojo;

public class CourseTest {
    private Integer id;

    private Integer courseId;

    private String testName;

    private Integer pice;

    private Integer flag;

    private String questiona;

    private String questionb;

    private String questionc;

    private String op;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName == null ? null : testName.trim();
    }

    public Integer getPice() {
        return pice;
    }

    public void setPice(Integer pice) {
        this.pice = pice;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public String getQuestiona() {
        return questiona;
    }

    public void setQuestiona(String questiona) {
        this.questiona = questiona == null ? null : questiona.trim();
    }

    public String getQuestionb() {
        return questionb;
    }

    public void setQuestionb(String questionb) {
        this.questionb = questionb == null ? null : questionb.trim();
    }

    public String getQuestionc() {
        return questionc;
    }

    public void setQuestionc(String questionc) {
        this.questionc = questionc == null ? null : questionc.trim();
    }

    public String getOp() {
        return op;
    }

    public void setOp(String op) {
        this.op = op == null ? null : op.trim();
    }
}