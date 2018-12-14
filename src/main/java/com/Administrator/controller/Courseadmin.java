package com.Administrator.controller;

import com.Administrator.service.CourseadminService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
public class Courseadmin {
    @Resource
    private CourseadminService service;
    @Resource
    private HttpServletRequest request;
    //记录当前访问分页
    private int Page;

    //待审核的资源列表
    @RequestMapping("/showCourseList")
    public String showCourseList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage, Model model){
        Page = currentPage;
        model.addAttribute("pagemsg", service.showCourseListByPage(currentPage));//回显分页数据

        return "showCourseList";
    }

    /*
    审核资源
     */
    //通过
    @RequestMapping("/adminCourseSuccess")
    public ModelAndView adminCourseSuccess(@RequestParam("id") int id, Model model){
        //更新flag位
        service.updateflagByid1(id);
        ModelAndView modelAndView = new ModelAndView("showCourseList","result","通过");
        model.addAttribute("pagemsg", service.showCourseListByPage(Page));//回显分页数据

        return modelAndView;

    }
    //不通过
    @RequestMapping("/adminCourseFailed")
    public ModelAndView adminCourseFailed(@RequestParam("id") int id,Model model){
        //更新flag位
        service.updateflagByid2(id);
        ModelAndView modelAndView = new ModelAndView("showCourseList","result","未通过");
        model.addAttribute("pagemsg",service.showCourseListByPage(Page));

        return modelAndView;
    }
}
