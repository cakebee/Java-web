package com.MessageManage.controller;

import com.MessageManage.pojo.Message;
import com.MessageManage.service.MessageService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
public class MessageController {
    @Resource
    private MessageService messageService;

    //消息中心首页，消息标题列表
    @RequestMapping(value = "/message", method = RequestMethod.GET)
    public ModelAndView messageIndex(@RequestParam(value = "currentPage", defaultValue = "1", required = false)int currentPage,
                                     HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView("messageList");

        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");


        modelAndView.addObject("pagemsg", messageService.getMessageList(currentPage, username,"receive"));
        modelAndView.addObject("currentPage", currentPage);


        return modelAndView;
    }

    @RequestMapping(value = "/singlemessage", method = RequestMethod.GET)
    public ModelAndView singleMesssage(@RequestParam(value = "id", required = true)int id){
        ModelAndView modelAndView;
        int messageId = id;
        Message message = messageService.getSingleMessage(messageId);
        modelAndView = new ModelAndView("singleMessage","message", message);
        messageService.setReaded(message);//设置已读
        return modelAndView;
    }

    @RequestMapping(value = "/editmessage", method = RequestMethod.GET)
    public ModelAndView editMessage(@RequestParam(value = "receID", required = false)String receID){
        Message message = new Message();
        message.setReceid(receID);
        return new ModelAndView("editMessage", "command", message);
    }

    @RequestMapping(value = "/sendmessage", method = RequestMethod.POST)
    public ModelAndView sendMessage(@ModelAttribute("SpingWeb") Message message, HttpServletRequest request){
        int result;
        HttpSession session = request.getSession();

        message.setSendid((String)session.getAttribute("username"));
        message.setFlag((byte)0);//设置未读
        message.setSender((byte)0);//设置发送方发件箱中该消息未删除
        message.setReceiver((byte)0);//设置接收方收件箱中该消息未删除
        message.setSendtime(new Date());//设置消息发送时间

        result = messageService.send(message);
        return new ModelAndView("sendSuccess", "command", message);
    }

    @RequestMapping(value = "/deletemessage", method = RequestMethod.GET)
    public ModelAndView deleteMessage(@RequestParam(value = "id")int id, HttpServletRequest request){
        Message message = messageService.getSingleMessage(id);
        String delMethod = request.getParameter("delmethod");

        System.out.println(delMethod);
        if(delMethod.equals("receiver")){
            messageService.delReceMessage(message);
        } else if(delMethod.equals("sender")){
            messageService.delSendedMessage(message);
            return new ModelAndView("redirect:/sended_message");
        }
        if(message.getSender()==(byte)1 && message.getReceiver()==(byte)1){
            messageService.deleteMessage(message);
        }
        return new ModelAndView("redirect:/message");
    }

    @RequestMapping(value = "/sended_message", method = RequestMethod.GET)
    public ModelAndView sendedMessage(@RequestParam(value = "currentPage", defaultValue = "1", required = false)int currentPage,
                                      HttpServletRequest request){
        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");
        return new ModelAndView("sendedMessage", "pagemsg", messageService.getMessageList(currentPage, username,"send"));
    }

    @RequestMapping(value = "/single_sended_message", method = RequestMethod.GET)
    public ModelAndView singleSendedMesssage(@RequestParam(value = "id")int id){
        ModelAndView modelAndView;
        int messageId = id;
        Message message = messageService.getSingleMessage(messageId);
        modelAndView = new ModelAndView("singleSendedMessage","message", message);

        return modelAndView;
    }
}
