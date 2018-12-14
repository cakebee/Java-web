package com.Administrator.controller;

import com.Administrator.service.adminService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
public class Resourcesadmin {
    @Resource
    private adminService service;
    @Resource
    private HttpServletRequest request;
    //记录当前访问页
    private int Page;
    /*
        分页查询
    */
    //审核上传资源列表
    @RequestMapping("/showResourceList")
    public String showResourceList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage, Model model){
        System.out.println("11"+currentPage);
        model.addAttribute("pagemsg", service.showResourceListByPage(currentPage));//回显分页数据
        Page = currentPage;
        //String username=(String)request.getAttribute("username");
        request.setAttribute("username","root");
        //System.out.println("11"+username);
        return "showResourcesList";
    }

    /*
    审核资源
     */
    //通过
    @RequestMapping("/adminResourceSuccess")
    public ModelAndView adminSuccess(@RequestParam("id") int id, Model model){
        service.updateflagByid1(id);
        ModelAndView modelAndView = new ModelAndView("showResourcesList","result","通过");
        model.addAttribute("pagemsg", service.showResourceListByPage(Page));//回显分页数据
        request.setAttribute("username","root");
        return modelAndView;

    }
    //不通过
    @RequestMapping("/adminResourceFailed")
    public ModelAndView adminFailed(@RequestParam("id") int id,Model model){
        service.updateflagByid2(id);
        ModelAndView modelAndView = new ModelAndView("showResourcesList","result","未通过");
        model.addAttribute("pagemsg",service.showResourceListByPage(Page));
        request.setAttribute("username","root");
        return modelAndView;
    }

}
