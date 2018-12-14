package com.Administrator.service;

import com.Administrator.dao.NoticeMapper;
import com.Administrator.pojo.Notice;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class NoticeService {
    @Resource
    private NoticeMapper noticeMapper;
    /*
用户表的记录总数
*/
    public int countUser(){
        return noticeMapper.selectCount();
    }
    /*
分页查询
*/
    public PageBean<Notice> showNoticeListByPage(int currentPage){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Notice> pageBean = new PageBean<Notice>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=5;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = noticeMapper.selectCount();
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<Notice> lists = noticeMapper.selectByPage(map);
        pageBean.setLists(lists);
        return pageBean;
    }
    public int insertNotice(Notice notice){
        notice.setNotitime(new Date());
        System.out.println(2);
        return noticeMapper.insert(notice);
    }

    public int deleteNotice(Integer id){
        return noticeMapper.deleteNotice(id);
    }
    public Notice selectNotice(Integer id){
        return noticeMapper.selectByPrimaryKey(id);
    }
}
