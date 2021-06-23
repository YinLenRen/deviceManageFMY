package app.action.imp;

import app.action.ShopingcartAction;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.DeviceDao;
import org.dao.ShopingcartDao;
import org.dao.UserDao;
import org.dao.imp.DeviceDaoImp;
import org.model.Device;
import org.model.Shopingcart;
import org.model.Shopingorder;
import org.model.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class ShopingcartActionImp extends ActionSupport implements ShopingcartAction, ServletRequestAware, ServletResponseAware {

    HttpServletRequest request;
    HttpServletResponse response;
    private ShopingcartDao shopingcartDao;
       private DeviceDao deviceDao;
       private UserDao userDao;



    public void setShopingcartDao(ShopingcartDao shopingcartDao) {
        this.shopingcartDao = shopingcartDao;
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }

    public void setDeviceDao(DeviceDao deviceDao) {
        this.deviceDao = deviceDao;
    }

    @Override
    public void findAllShopingcart() throws IOException {
        List<Shopingcart> list = shopingcartDao.findAllShopingcart();
        makeJson(list);
    }



    void makeJson(List<Shopingcart> list) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONArray jsonArray = new JSONArray();
        for(Shopingcart c : list){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("ShopingcartID", c.getShopingcartId());
            Device dev = deviceDao.findDeviceById(new Integer(c.getDevice().getDeviceId()));

            JSONObject jsonDev = new JSONObject();
            jsonDev.put("DevcieID", dev.getDeviceId());
            jsonDev.put("DeviceClassID", dev.getDeviceclass().getDeviceClassId());
            jsonDev.put("DeviceName", dev.getDeviceName());
            jsonDev.put("DevicePrice", dev.getDevicePrice());
            jsonObject.put("Device", jsonDev);
            jsonObject.put("BuyNum", c.getBuyNum());

            JSONObject jsonUser = new JSONObject();
            User user = userDao.findUserById(c.getUser().getUserId());
            jsonUser.put("UserID", user.getUserId());
            jsonUser.put("UserName", user.getUserName());
            jsonObject.put("User", jsonUser);

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
    public void findShopingcartById() throws IOException {
        String id = request.getParameter("shopingcartId");
        Shopingcart s = shopingcartDao.findShopingcartById(new Integer(id));
        List<Shopingcart> list = new ArrayList<Shopingcart>();
        list.add(s);
        makeJson(list);
    }

    @Override
    public void findAllShopingcartByUserId() throws IOException {
        String id = request.getParameter("userId");
        List<Shopingcart> list = shopingcartDao.findShopingcartByUserId(new Integer(id));
        makeJson(list);
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public String addShopingcart() {
        String deviceId = request.getParameter("deviceId");
        String BuyNum = request.getParameter("buyNum");
        String userId = request.getParameter("userId");
        Shopingcart s = new Shopingcart();
        Device dev = deviceDao.findDeviceById(new Integer(deviceId));
        s.setDevice(dev);
        User u = userDao.findUserById(new Integer(userId));
        s.setUser(u);
        s.setBuyNum(new Integer(BuyNum));
        shopingcartDao.addShopingcart(s);
        return SUCCESS;
    }

    @Override
    public String deleteShopingcart() {
        String id = request.getParameter("deleteShopingcartId");
        shopingcartDao.deleteShopingcart(shopingcartDao.findShopingcartById(new Integer(id)));
        return SUCCESS;
    }

    @Override
    public String calulation() {
        String UserId = request.getParameter("userId");
        String receive = request.getParameter("receive");
        String receiveAddress = request.getParameter("receiveAddress");
        String createtime = request.getParameter("createtime");
       // String moneyAmount = request.getParameter("moneyAmount");
        Shopingorder shopingorder = new Shopingorder();
        shopingorder.setCreatetime(createtime);
        shopingorder.setReceiveAddress(receiveAddress);
        shopingorder.setReceiver(receive);
        User user = userDao.findUserById(new Integer(UserId));
        shopingorder.setUser(user);

        List<Shopingcart> list = new ArrayList<Shopingcart>();
        String shopingids = request.getParameter("shopingcartids");
        String shopingcartIdList[] = shopingids.split(",");
        int ans = 0;
        for(String id : shopingcartIdList){
            Shopingcart sc = shopingcartDao.findShopingcartById(new Integer(id));
            Device device = deviceDao.findDeviceById(new Integer(sc.getDevice().getDeviceId()));
            String devicePrice = device.getDevicePrice();
            int buyNum = sc.getBuyNum();
            ans += new Integer(devicePrice) * buyNum;
            list.add(sc);
        }
        shopingorder.setMoneyAmount(Integer.toString(ans));
        shopingcartDao.calulation(shopingorder, list);
        return SUCCESS;
    }

    @Override
    public void updateShoppingcart() {
        String shoppingcartId = request.getParameter("shoppingcartId");
        String deviceId = request.getParameter("deviceId");
        String buyNum = request.getParameter("buyNum");
        String userId = request.getParameter("userId");
        Shopingcart shopingcart = shopingcartDao.findShopingcartById(new Integer(shoppingcartId));
        shopingcart.setBuyNum(new Integer(buyNum));

        User user = userDao.findUserById(new Integer(userId));
        shopingcart.setUser(user);

        Device device = deviceDao.findDeviceById(new Integer(deviceId));
        shopingcart.setDevice(device);
        shopingcartDao.updateShoppingcart(shopingcart);

    }
}
