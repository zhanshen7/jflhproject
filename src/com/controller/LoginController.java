package com.controller;

import com.model.User;
import com.model.UserDAO;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class LoginController {

    private final HttpServletRequest request;
    private UserDAO userDAO;

    @Autowired
    public LoginController(HttpServletRequest request) {
        this.request = request;
        ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
        this.userDAO = (UserDAO) context.getBean("userDAO");
        System.out.println("load userDAO successfully.");
    }

    //login action
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String Login(@ModelAttribute User user) {
        System.out.println("ready login.");
        List<User> userList = userDAO.getUserByPhone(user.getPhone());
        if (userList.size() != 0 && userList.get(0).getPassword().equals(user.getPassword())) {
            request.getSession().setAttribute("user", userList.get(0));
            System.out.println("login successfully.");
        }
        return "redirect:/";
    }

    //register action
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String Register(@ModelAttribute User user) {
        System.out.println("ready register.");
        List<User> userList = userDAO.getUserByPhone(user.getPhone());
        if (userList.size() == 0 &&
                user.getPhone().matches("/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/") &&
                user.getPhone().matches("/^[A-Za-z~!%^&*]+[0-9]|[A-Za-z~!%^&*]$/")) {
            userDAO.createUser(user.getPhone(), user.getPassword());
            System.out.println("register successfully.");
        } else {
            System.out.println("register failed");
        }
        return "redirect:/";
    }

    //Ajax validate login form
    @RequestMapping(value = "/Ajax/login", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject AjaxLogin(@ModelAttribute User user) {
        List<User> userList = userDAO.getUserByPhone(user.getPhone());
        JSONObject jsonObject = new JSONObject();
        if (userList.size() != 0 && userList.get(0).getPassword().equals(user.getPassword())) {
            jsonObject.put("valid", "true");
        }
        return jsonObject;
    }

    //Ajax validate register form
    @RequestMapping(value = "/Ajax/register", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject AjaxRegister(@RequestParam(value = "phone") String phone) {
        List<User> userList = userDAO.getUserByPhone(phone);
        JSONObject jsonObject = new JSONObject();
        if (userList.size() == 0) {
            jsonObject.put("valid", "true");
        }
        return jsonObject;
    }
}
