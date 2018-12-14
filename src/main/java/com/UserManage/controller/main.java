package com.UserManage.controller;

import com.Administrator.service.NoticeService;
import com.CourseManage.service.CourseManageService;
import com.UserManage.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
public class main {
    @Resource
    private NoticeService service;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private UserService userService;
    //启动服务后首次访问的页面
    @RequestMapping("/")
    public String index(ModelMap model){

        //热门课程
        model.addAttribute("pagemsgHotCourse",courseManageService.showHotCourse());
        model.addAttribute("coursetypes",userService.getTags());
        model.addAttribute("keywords","null");

        //回显公告分页数据
        model.addAttribute("pagemsg", service.showNoticeListByPage(1));

        model.addAttribute("message", "退役士兵网络培训平台");
        return "index";
    }


}
