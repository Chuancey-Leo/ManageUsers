package org.controller;

import com.google.gson.Gson;
import net.sf.json.JSONObject;
import org.entity.User;
import org.dao.UserDao;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
        for (User u:userList) {
            System.out.println(u.getTypeName());
        }
        info.put("data", userList);
        String json = new Gson().toJson(info);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();

        out.write(json);
        return null;
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam(value = "id")Integer id, HttpServletResponse response)throws Exception{
        userDao.delete(id);
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("success",true);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.print(jsonObject);
        return null;
    }

    @RequestMapping("/add")
    public ModelAndView add(){
        ModelAndView mv=new ModelAndView("add");
        return mv;
    }

    @RequestMapping("/addData")
    public String addData(@RequestParam(value = "id")String number,
                          @RequestParam(value = "type")String type,
                          @RequestParam(value = "state")String state,
                          @RequestParam(value = "userName")String userName,
                          @RequestParam(value = "start")String start,
                          @RequestParam(value = "last")String last,
                          HttpServletResponse response)throws Exception{

        User user=new User();
        user.setTypeName(type);
        user.setNumber(number);
        user.setUserName(userName);
        user.setState(state);
        Date date1;
        Date date2;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        date1=format.parse(start);
        date2=format.parse(last);
        user.setCreateTime(date1);
        user.setLastLogin(date2);
        userDao.add(user);

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("success",true);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.print(jsonObject);
        return null;
    }

    @RequestMapping("/update/{id}")
    public ModelAndView update(@PathVariable("id") String id){
        ModelAndView mv=new ModelAndView("update");
        User user=userDao.findById(id);
        mv.addObject("user",user);
        return mv;
    }

    @RequestMapping("/updateData")
    public String updateData(@RequestParam(value = "id")String number,
                          @RequestParam(value = "type")String type,
                          @RequestParam(value = "state")String state,
                          @RequestParam(value = "userName")String userName,
                          @RequestParam(value = "start")String start,
                          @RequestParam(value = "last")String last,
                          HttpServletResponse response)throws Exception{

        User user=new User();
        user.setTypeName(type);
        user.setNumber(number);
        user.setUserName(userName);
        user.setState(state);
        Date date1;
        Date date2;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        date1=format.parse(start);
        date2=format.parse(last);
        user.setCreateTime(date1);
        user.setLastLogin(date2);
        userDao.update(user);

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("success",true);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.print(jsonObject);
        return null;
    }

}
