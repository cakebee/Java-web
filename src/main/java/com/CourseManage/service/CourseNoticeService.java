package com.CourseManage.service;

import com.CourseManage.dao.CourseNoticeMapper;
import com.CourseManage.pojo.CourseNotice;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class CourseNoticeService {
    @Resource
    private CourseNoticeMapper courseNoticeMapper;

    public PageBean<CourseNotice> getAllNoticeSummary(int courseId, int currentPage){
        int pageSize = 10;//每页显示10条数据
        int totalCount;
        double tc;
        PageBean<CourseNotice> pageBean = new PageBean<CourseNotice>();
        List<CourseNotice> noticesList;
        Double num;
        HashMap<String,Object> map = new HashMap<String, Object>();
        totalCount = courseNoticeMapper.selectNoticeCount(courseId);

        tc = totalCount;
        num = Math.ceil(tc/pageSize);

        pageBean.setTotalCount(totalCount);
        pageBean.setTotalPage(num.intValue());
        pageBean.setCurrPage(currentPage);
        pageBean.setPageSize(pageSize);

        map.put("start", (currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseId", courseId);

        noticesList = courseNoticeMapper.selectAllByCourseId(map);
        pageBean.setLists(noticesList);

        return pageBean;
    }

    public int addNotice(CourseNotice courseNotice){
        return courseNoticeMapper.insert(courseNotice);
    }

    public int delNotice(int courseNoticeID){
        return courseNoticeMapper.deleteByPrimaryKey(courseNoticeID);
    }

    public int updateNotice(CourseNotice courseNotice){
        courseNotice.setTime(new Date());
        return courseNoticeMapper.updateByPrimaryKey(courseNotice);
    }

    public CourseNotice getNotice(int noticeId){
        return courseNoticeMapper.selectByPrimaryKey(noticeId);
    }

    public List<CourseNotice> getLatestNotices(int courseID, int size){
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("start", 0);
        map.put("size", size);
        map.put("courseId", courseID);
        return courseNoticeMapper.selectAllByCourseId(map);
    }
}
