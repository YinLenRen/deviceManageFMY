package app.action.imp;

import app.action.ShopingorderitemAction;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.DeviceDao;
import org.dao.ShopingorderDao;
import org.dao.ShopingorderitemDao;
import org.model.Device;
import org.model.Shopingorder;
import org.model.Shopingorderitem;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class ShopingorderitemActionImp extends ActionSupport implements ShopingorderitemAction, ServletRequestAware, ServletResponseAware {
    
    HttpServletRequest request;
    HttpServletResponse response;
    ShopingorderitemDao shopingorderitemDao;
    DeviceDao deviceDao;
    ShopingorderDao shopingorderDao;

    public void setShopingorderDao(ShopingorderDao shopingorderDao) {
        this.shopingorderDao = shopingorderDao;
    }

    public void setDeviceDao(DeviceDao deviceDao) {
        this.deviceDao = deviceDao;
    }

    public void setShopingorderitemDao(ShopingorderitemDao shopingorderitemDao) {
        this.shopingorderitemDao = shopingorderitemDao;
    }

    @Override
    public void findAllShopingorderitem() throws IOException {
        List<Shopingorderitem> list = shopingorderitemDao.findAllShopingorderitem();
        makeJson(list);
    }

    void makeJson(List<Shopingorderitem> list) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONArray jsonArray = new JSONArray();
        for(Shopingorderitem s : list){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("ShopingOrderItemID", s.getShopingOrderItemId());
            jsonObject.put("ShopingOrderID", s.getShopingorder().getShopingOrderId());
            jsonObject.put("BuyNum", s.getBuyNum());
            Device dev = s.getDevice();
            JSONObject jsonDev = new JSONObject();
            jsonDev.put("DeviceId", dev.getDeviceId());
            jsonDev.put("DeviceClassId", dev.getDeviceclass().getDeviceClassId());
            jsonDev.put("DeviceName", dev.getDeviceName());
            jsonDev.put("DevicePrice", dev.getDevicePrice());
            jsonObject.put("Device", jsonDev);
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
    public void findShopingorderitemById() throws IOException {
        String id = request.getParameter("shopingOrderItemId");
        Shopingorderitem shopingorder = shopingorderitemDao.findShopingorderitemById(new Integer(id));
        List<Shopingorderitem> list = new ArrayList<Shopingorderitem>();
        list.add(shopingorder);
        makeJson(list);
    }

    @Override
    public void findShopingorderitemByShopingorderId() throws IOException {
        String id = request.getParameter("shopingOrderId");
        List<Shopingorderitem> list = shopingorderitemDao.findShopingorderitemByShopingorderId(new Integer(id));
        makeJson(list);
    }


    @Override
    public String addShopingorderitem(){
        String shopingOrderID = request.getParameter("shopingOrderId");
        String deviceID = request.getParameter("deviceId");
        String buyNum = request.getParameter("buyNum");
        Shopingorderitem shopingorderitem = new Shopingorderitem();
        Shopingorder shopingorder = shopingorderDao.findShopingorderById(new Integer(shopingOrderID));
        shopingorderitem.setShopingorder(shopingorder);
        Device dev = deviceDao.findDeviceById(new Integer(deviceID));
        shopingorderitem.setDevice(dev);
        shopingorderitem.setBuyNum(new Integer(buyNum));
        shopingorderitemDao.addShopingorderitem(shopingorderitem);
        return SUCCESS;
    }

    @Override
    public String deleteShopingorderitem() {
        String id = request.getParameter("deleteShopingorderitemId");
        shopingorderitemDao.deleteShopingorderitem(shopingorderitemDao.findShopingorderitemById(new Integer(id)));
        return SUCCESS;

    }

    @Override
    public void updateShoppingorderitem() {
        String id = request.getParameter("shopingorderitemId");
        String orderId = request.getParameter("shoppingorderId");
        String deviceName = request.getParameter("deviceName");
        String buyNum = request.getParameter("buyNum");
        List<Device> device = deviceDao.findDeviceByName(deviceName);
        Shopingorderitem shopingorderitem = new Shopingorderitem();
        shopingorderitem.setDevice(device.get(0));
        shopingorderitem.setBuyNum(new Integer(buyNum));
        shopingorderitem.setShopingorder(shopingorderDao.findShopingorderById(new Integer(orderId)));
        shopingorderitem.setShopingOrderItemId(new Integer(id));
        shopingorderitemDao.updateShoppingorderitem(shopingorderitem);

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
