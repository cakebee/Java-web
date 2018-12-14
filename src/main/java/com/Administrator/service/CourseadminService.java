package com.Administrator.service;


import com.CourseManage.dao.CourseMapper;
import com.CourseManage.pojo.Course;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class CourseadminService {
   @javax.annotation.Resource
    private CourseMapper courseMapper;
    /*
    用户表的记录总数
 */
    public int countUser(){
        return courseMapper.selectCountadmin();
    }
    /*
    分页查询
 */
    public PageBean<Course> showCourseListByPage(int currentPage){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Course> pageBean = new PageBean<Course>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=5;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseMapper.selectCountadmin();
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<Course> lists = courseMapper.selectByPageadmin(map);
        pageBean.setLists(lists);
        return pageBean;
    }


    public int updateflagByid1(int id){return courseMapper.updateflagByid1(id);}
    public int updateflagByid2(int id){return courseMapper.updateflagByid2(id);}
}
