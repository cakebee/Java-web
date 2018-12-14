package com.CourseManage.service;

import com.CourseManage.dao.CourseIndexMapper;
import com.CourseManage.pojo.CourseIndex;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CourseIndexService {
    @Resource
    private CourseIndexMapper courseIndexMapper;

    public List<CourseIndex> getCourseIndexList(int courseID){
        return courseIndexMapper.selectByCourseID(courseID);
    }

    public boolean updateCourseResource(int courseIndexID, String type, int resourceID){
        CourseIndex courseIndex = new CourseIndex();
        courseIndex.setId(courseIndexID);
        if(type.equals("Video")){
            courseIndex.setVideo(resourceID);
            courseIndexMapper.updateVideoByPK(courseIndex);
            return true;
        }else if(type.equals("Pdf")){
            courseIndex.setPdf(resourceID);
            courseIndexMapper.updatePDFByPK(courseIndex);
            return true;
        }else if(type.equals("Word")){
            courseIndex.setWord(resourceID);
            courseIndexMapper.updateWordByPK(courseIndex);
            return true;
        }
        return false;
    }

    public boolean addCourseIndex(CourseIndex courseIndex){
        if(isExist(courseIndex.getCourseid(), courseIndex.getChapter(), courseIndex.getPart())){
            return false;
        }else{
            if(courseIndexMapper.insert(courseIndex) != 0){
                return true;
            }
            return false;
        }
    }

    public boolean delCourseIndex(int courseIndexID){
        int result = courseIndexMapper.deleteByPrimaryKey(courseIndexID);
        if(result != 0){
            return true;
        }
        return false;
    }

    public boolean isExist(int courseID, int chapter, int part){
        CourseIndex courseIndex = new CourseIndex();

        courseIndex.setCourseid(courseID);
        courseIndex.setChapter(chapter);
        courseIndex.setPart(part);

        if(courseIndexMapper.selectByCourseIDChapterPart(courseIndex) != null){
            return true;
        }else {
            return false;
        }
    }
    public boolean isExist(CourseIndex courseIndex){
        if(courseIndexMapper.selectByCourseIDChapterPart(courseIndex) != null){
            return true;
        }else {
            return false;
        }
    }

    public int getCouseIndexID(CourseIndex courseIndex){
        return courseIndexMapper.selectByCourseIDChapterPart(courseIndex).getId();
    }

    public CourseIndex getCourseIndex(int videoID){
        List<CourseIndex> courseIndexList = courseIndexMapper.selectByVideoID(videoID);
        if(courseIndexList.size() != 0){
            return courseIndexList.get(0);
        }
        return null;
    }
}
