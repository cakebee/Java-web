package com.Administrator.controller;

import com.Administrator.pojo.Notice;
import com.Administrator.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
public class Noticeadmin {
    @Resource
    private NoticeService service;
    @Resource
    private HttpServletRequest request;
    //记录当前访问页
    private int page;
    //查看公告列表
    @RequestMapping("/showNoticeList")
    public String showResourceList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage, Model model){
        page = currentPage;
        model.addAttribute("pagemsg", service.showNoticeListByPage(currentPage));//回显分页数据
        return "showNoticeList";
    }
    //发布公告
    @RequestMapping(value = "/Announcements")
    public ModelAndView printlogin(){
        ModelAndView modelandview = new ModelAndView("Announcements", "command", new Notice());
        return modelandview;
    }

    @RequestMapping(value = "/AnnouncementsResult",method = RequestMethod.POST)
    public ModelAndView dopost(@ModelAttribute("command")Notice notice, ModelMap model){
        ModelAndView modelandview;
        System.out.println(1);
        int result = service.insertNotice(notice);
        if(result == 1){
            modelandview = new ModelAndView("Announcements", "command", notice);
            model.addAttribute("result", "发布成功");
            //TODO:3s后跳转到原界面
            //model.addAttribute("url", "login");
        }else{
            modelandview = new ModelAndView("Announcements", "command",notice);
            model.addAttribute("result", "发布失败");
            //TODO:3s后跳转到源界面
            // model.addAttribute("url", "register");
        }
        return modelandview;
    }
    //删除公告
    @RequestMapping("/deleteNotice")
    public ModelAndView adminSuccess(@RequestParam("id") int id, Model model){
        int result = service.deleteNotice(id);
        ModelAndView modelAndView;
        if (result == 1){modelAndView = new ModelAndView("showNoticeList","result","success");}
        else { modelAndView = new ModelAndView("showNoticeList","result","fail");}
        model.addAttribute("pagemsg", service.showNoticeListByPage(page));//回显分页数据
        return modelAndView;

    }
    //查看公告时点击查看详情
    @RequestMapping("/showDetail")
    public ModelAndView showDetail(@RequestParam("id") int id,Model model){
        Notice notice = service.selectNotice(id);
        ModelAndView modelAndView = new ModelAndView("showDetail","content",notice.getContent());
        model.addAttribute("title",notice.getTitle());
        return modelAndView;
    }
}
