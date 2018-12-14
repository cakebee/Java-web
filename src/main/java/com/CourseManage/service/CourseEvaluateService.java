package com.CourseManage.service;

import com.CourseManage.dao.CourseEvaluateMapper;
import com.CourseManage.pojo.CourseEvaluate;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class CourseEvaluateService {
    @javax.annotation.Resource
    private CourseEvaluateMapper courseEvaluateMapper;
    /*
    用户表的记录总数
 */
    public int countCourseEvaluate(int courseid){
        return courseEvaluateMapper.selectCount(courseid);
    }
    /*
    分页查询
 */
    public PageBean<CourseEvaluate> showCourseEvaluateListByPage(int currentPage,int courseID){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<CourseEvaluate> pageBean = new PageBean<CourseEvaluate>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseEvaluateMapper.selectCount(courseID);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseid",courseID);
        //封装每页显示的数据
        List<CourseEvaluate> lists = courseEvaluateMapper.selectByPage(map);
        pageBean.setLists(lists);
        return pageBean;
    }
    public int insertCourseEvaluate(CourseEvaluate courseEvaluate){
        courseEvaluate.setTime(new Date());
        Integer score1 = courseEvaluate.getScore1();
        Integer score2 = courseEvaluate.getScore2();
        Integer score3 = courseEvaluate.getScore3();
        Integer score = (score1+score2+score3)/3;
        courseEvaluate.setScore(score);
        return courseEvaluateMapper.insert(courseEvaluate);
    }
}
