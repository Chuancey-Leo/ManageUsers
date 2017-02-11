package org.controller;

import com.google.gson.Gson;
import net.sf.json.JSONObject;
import org.User;
import org.dao.UserDao;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by liao on 17-2-9.
 */


@Controller
@RequestMapping("/user")
public class UserController {

    UserDao userDao=new UserDao();
    @RequestMapping("/index")
    public ModelAndView testFreeMarker(HttpServletRequest request){

        ModelAndView mv=new ModelAndView("index");
        List<User> userList=userDao.list();
        //JSONObject jsonObject=new JSONObject();
        mv.addObject("userList",userList);
        return mv;
    }

    @RequestMapping("/list")
    public String list(HttpServletResponse response)throws Exception{
        List<User> userList=userDao.list();
        //ModelAndView mv=new ModelAndView("index");
        Map<Object, Object> info = new HashMap<Object, Object>();
        info.put("data", userList);
        String json = new Gson().toJson(info);
        PrintWriter out=response.getWriter();
        response.setContentType("text/html;charset=utf-8");
        out.write(json);
        return null;
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam(value = "id")Integer id, HttpServletResponse response)throws Exception{
        userDao.delete(id);
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("success",true);
        PrintWriter out=response.getWriter();
        response.setContentType("text/html;charset=utf-8");
        out.print(jsonObject);
        return null;
    }
}
