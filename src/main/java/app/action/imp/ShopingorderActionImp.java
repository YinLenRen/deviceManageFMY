package app.action.imp;

import app.action.ShopingorderAction;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.ShopingorderDao;
import org.dao.UserDao;
import org.model.Device;
import org.model.Shopingorder;
import org.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class ShopingorderActionImp extends ActionSupport implements ShopingorderAction, ServletResponseAware, ServletRequestAware {

    HttpServletResponse response;
    HttpServletRequest request;
    ShopingorderDao shopingorderDao;

    public void setShopingorderDao(ShopingorderDao shopingorderDao) {
        this.shopingorderDao = shopingorderDao;
    }

    @Override
    public void findAllShopingorder() throws IOException {
        List<Shopingorder> list = shopingorderDao.findAllShopingorder();
        makeJson(list);

    }

    void makeJson(List<Shopingorder> list) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONArray jsonArray = new JSONArray();
        for(Shopingorder s : list){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("ShopingOrderId", s.getShopingOrderId());
            jsonObject.put("UserId", s.getUser().getUserId());
            jsonObject.put("Receiver",s.getReceiver());
            jsonObject.put("ReceiverAddress", s.getReceiveAddress());
            jsonObject.put("Createtime", s.getCreatetime());
            jsonObject.put("MoneyAmount", s.getMoneyAmount());
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
    public void findShopingorderById() throws IOException {
        String id = request.getParameter("shopingOrderId");
        Shopingorder shopingorder = shopingorderDao.findShopingorderById(new Integer(id));
        List<Shopingorder> list = new ArrayList<Shopingorder>();
        list.add(shopingorder);
        makeJson(list);
    }

    @Override
    public void findShopingorderByUserId() throws IOException {
        String id = request.getParameter("userId");
        List<Shopingorder> list = shopingorderDao.findShopingorderByUserId(new Integer(id));
        makeJson(list);
    }

    UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public String addShopingorder() {
        String UserId = request.getParameter("userId");
        String receive = request.getParameter("receive");
        String receiveAddress = request.getParameter("receiveAddress");
        String createtime = request.getParameter("createtime");
        String moneyAmount = request.getParameter("moneyAmount");
        Shopingorder shopingorder = new Shopingorder();
        shopingorder.setCreatetime(createtime);
        shopingorder.setMoneyAmount(moneyAmount);
        shopingorder.setReceiveAddress(receiveAddress);
        shopingorder.setReceiver(receive);
        User user = userDao.findUserById(new Integer(UserId));
        shopingorder.setUser(user);
        shopingorderDao.addShopingorder(shopingorder);
        return SUCCESS;
    }

    @Override
    public String deleteShopingorder() {
        String id = request.getParameter("deleteShopingorderId");
        shopingorderDao.deleteShopingorder(shopingorderDao.findShopingorderById(new Integer(id)));
        return SUCCESS;
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }
}
