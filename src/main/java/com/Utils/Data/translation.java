package com.Utils.Data;

import org.springframework.stereotype.Service;

@Service("translation")
public class translation {
    private String result;

    public String getResult(String src) {
        if("teacher".equals(src)){
            result = "老师";
        }
        if("student".equals(src)){
            result = "学生";
        }
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
