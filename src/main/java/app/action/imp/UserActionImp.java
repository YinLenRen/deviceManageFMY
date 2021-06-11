package app.action.imp;

import app.action.UserAction;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.UserDao;
import org.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class UserActionImp extends ActionSupport implements UserAction, ServletResponseAware, ServletRequestAware {

    HttpServletResponse httpServletResponse;
    HttpServletRequest httpServletRequest;
    UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public void findAllUser() throws IOException {
        List<User> list = userDao.findAllUser();
        makeJson(list);
    }

    void makeJson(List<User> list) throws IOException {
        httpServletResponse.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = httpServletResponse.getWriter();
        JSONArray jsonArray = new JSONArray();
        for(User u : list){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("UserId", u.getUserId());
            jsonObject.put("UserName", u.getUserName());
            jsonObject.put("UserPassword", u.getUserPassword());
            jsonArray.add(jsonObject);
        }
        System.out.println(jsonArray.toString());
        JSONObject root = new JSONObject();
        root.put("result", jsonArray);
        out.write(root.toString());
        out.flush();
        out.close();
    }

    @Override
    public void findUserById() throws IOException {
        String id = httpServletRequest.getParameter("userId");
        User u = userDao.findUserById(new Integer(id));
        List<User> list = new ArrayList<User>();
        list.add(u);
        makeJson(list);
    }

    @Override
    public void login() throws IOException {
        String name = httpServletRequest.getParameter("userName");
        String password = httpServletRequest.getParameter("userPassword");
        User user = userDao.login(name, password);
        List<User> list = new ArrayList<User>();
        list.add(user);
        makeJson(list);

    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.httpServletRequest = httpServletRequest;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.httpServletResponse = httpServletResponse;
    }
}
