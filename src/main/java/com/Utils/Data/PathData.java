package com.Utils.Data;

import org.springframework.stereotype.Service;

import java.io.File;

@Service("PathData")
public class PathData {


    /*path on linux*/
    /*private String rootPath = File.separator + "home" + File.separator + "web" + File.separator + "sourcefiles" + File.separator + "tysowlpx" + File.separator;*/

    /*path on windows*/
    private String rootPath = "D:"+ File.separator + "Resources"+ File.separator + "web" + File.separator + "sourcefiles" + File.separator + "tysowlpx" + File.separator;

    private  String coursePath = rootPath + "course";

    private  String workPath = rootPath + "work";

    private  String resourcePath = rootPath + "resource";

    public String getWorkPath() {
        return workPath;
    }

    public void setWorkPath(String workPath) {
        this.workPath = workPath;
    }

    public  String getCoursePath() {
        return coursePath;
    }

    public  void setCoursePath(String coursePath) {
        this.coursePath = coursePath;
    }

    public String getResourcePath() {
        return resourcePath;
    }

    public void setResourcePath(String resourcePath) {
        this.resourcePath = resourcePath;
    }
}
