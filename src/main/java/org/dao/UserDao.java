package org.dao;

import org.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import java.util.List;

/**
 * Created by liao on 17-2-9.
 */


public class UserDao {

    ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
    JdbcTemplate f = applicationContext.getBean("jdbcTemplate", JdbcTemplate.class);

    //查询所有数据
    public List<User> list(){
        String sql = "SELECT * FROM user";

        List<User> userList=f.query(sql,new BeanPropertyRowMapper(
                User.class));
        return userList;
    }
    //删除数据
    public void delete(int id){
        String sql="delete from user where number=?";
        f.update(sql,id);
    }
}
