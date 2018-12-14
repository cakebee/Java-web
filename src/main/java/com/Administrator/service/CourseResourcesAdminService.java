package com.Administrator.service;

import com.CourseManage.dao.CourseResourcesMapper;
import com.CourseManage.pojo.CourseResources;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class CourseResourcesAdminService {
    @javax.annotation.Resource
    private CourseResourcesMapper courseResourcesMapper;
    /*
    用户表的记录总数
 */
    public int countUser(){
        return courseResourcesMapper.selectCount();
    }
    /*
    分页查询
 */
    public PageBean<CourseResources> showCourseResourcesListByPage(int currentPage){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<CourseResources> pageBean = new PageBean<CourseResources>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=5;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseResourcesMapper.selectCount();
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<CourseResources> lists = courseResourcesMapper.selectByPage(map);
        pageBean.setLists(lists);
        return pageBean;
    }


    public int updateflagByid1(int id){return courseResourcesMapper.updateflagByid1(id);}
    public int updateflagByid2(int id){return courseResourcesMapper.updateflagByid2(id);}
}
