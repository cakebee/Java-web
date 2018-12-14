package com.CourseManage.service;

import com.CourseManage.dao.CourseImageMapper;
import com.CourseManage.pojo.CourseImage;
import com.Utils.Data.PathData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@Service
public class CourseImageService {
    @Resource
    private CourseImageMapper courseImageMapper;
    @Resource
    private PathData pathData;
    public int insert(byte[] image,int courseid)throws IOException {
        if(image.length==0){
            File file = new File(pathData.getCoursePath()+File.separator+"courseDefaultImage.png");
            FileInputStream fis = new FileInputStream(file);
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            byte[] b = new byte[1024];

            int n;
            while ((n = fis.read(b)) != -1)
            {
                bos.write(b, 0, n);
            }
            fis.close();
            bos.close();
            image = bos.toByteArray();
        }

        CourseImage courseImage1 = new CourseImage();
        courseImage1.setCourseImage(image);
        courseImage1.setCourseid(courseid);
        return courseImageMapper.insert(courseImage1);
    }

    public CourseImage select(int courseid){

        return courseImageMapper.selectBycourseid(courseid);

    }

    public int updateByCourseid(byte[] image,int courseid)throws IOException{
        CourseImage courseImage = new CourseImage();
        courseImage.setCourseImage(image);
        courseImage.setCourseid(courseid);


        if (select(courseImage.getCourseid())!=null){
            courseImage.setId(courseImageMapper.selectBycourseid(courseid).getId());
            return courseImageMapper.updateByPrimaryKeyWithBLOBs(courseImage);
        }
        else {
            return insert(image,courseid);
        }
    }

}
