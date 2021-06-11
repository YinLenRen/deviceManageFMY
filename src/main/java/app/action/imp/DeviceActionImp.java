package app.action.imp;

import app.action.DeviceAction;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.DeviceClassDao;
import org.dao.DeviceDao;
import org.model.Device;
import org.model.Deviceclass;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class DeviceActionImp extends ActionSupport implements DeviceAction, ServletResponseAware, ServletRequestAware {

    HttpServletResponse response;
    HttpServletRequest request;
    DeviceDao deviceDao;
    DeviceClassDao deviceClassDao;

    public void setDeviceDao(DeviceDao deviceDao) {
        this.deviceDao = deviceDao;
    }

    public void setDeviceClassDao(DeviceClassDao deviceClassDao) {
        this.deviceClassDao = deviceClassDao;
    }

    @Override
    public void findAllDevice() throws IOException {
        List<Device> list = deviceDao.findAllDevice();
        makeJson(list);
    }

    @Override
    public void findDeviceByDeviceClassId() throws IOException {
        String deviceClassId = request.getParameter("deviceClassId");
        List<Device> list = deviceDao.findDeviceByDeviceClassId(new Integer(deviceClassId));
        makeJson(list);
    }


    @Override
    public void findDeviceByName() throws IOException {
        String name = request.getParameter("deviceName");
        List<Device> dev = deviceDao.findDeviceByName(name);
        makeJson(dev);
    }

    @Override
    public void findDeviceByPrice() throws IOException {
        String low = request.getParameter("low");
        String high = request.getParameter("high");
        List<Device> list = deviceDao.findDeviceByPrice(low, high);
        makeJson(list);
    }


    public void findDeviceByFuzzy() throws IOException {
        String deviceClassName = request.getParameter("deviceClassName");
        String deviceName = request.getParameter("deviceName");
        String low = request.getParameter("low");
        String high = request.getParameter("high");
        List<Device> list = deviceDao.findDeviceByFuzzy(deviceClassName, deviceName, low, high);
        makeJson(list);
       // return SUCCESS;
    }

    @Override
    public void updateDeviceById() throws IOException {
        String deviceId = request.getParameter("deviceId");
        String deviceName = request.getParameter("deviceName");
        String devicePrice = request.getParameter("devicePrice");
        deviceDao.updateDeviceById(new Integer(deviceId), deviceName, devicePrice);

        Device dev = deviceDao.findDeviceById(new Integer(deviceId));
        List<Device> list = new ArrayList<Device>();
        list.add(dev);
        makeJson(list);

    }

    @Override
    public void deleteDevice() {
        String id = request.getParameter("deviceId");
        deviceDao.deleteDevice(deviceDao.findDeviceById(new Integer(id)));
    }

    @Override
    public void editDevice() {
        String deviceId = request.getParameter("deviceId");
        String deviceClassId = request.getParameter("deviceClassId");
        String name = request.getParameter("deviceName");
        String price = request.getParameter("devicePrice");
        Device device = new Device();
        Deviceclass dc = deviceClassDao.findDeviceClass(new Integer(deviceClassId));
        device.setDeviceclass(dc);
        device.setDeviceName(name);
        device.setDevicePrice(price);
        device.setDeviceId(new Integer(deviceId));
        deviceDao.editDevice(device);
    }

    @Override
    public void addDevice() {
        String deviceId = request.getParameter("deviceId");
        String deviceClassId = request.getParameter("deviceClassId");
        String name = request.getParameter("deviceName");
        String price = request.getParameter("devicePrice");
        Device device = new Device();
        Deviceclass dc = deviceClassDao.findDeviceClass(new Integer(deviceClassId));
        device.setDeviceclass(dc);
        device.setDeviceName(name);
        device.setDevicePrice(price);
        device.setDeviceId(new Integer(deviceId));
        deviceDao.addDevice(device);
    }

    void makeJson(List<Device> list) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONArray jsonArray = new JSONArray();
        for(Device d : list){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("DeviceId", d.getDeviceId());
            jsonObject.put("DeviceClassId", d.getDeviceclass().getDeviceClassId());
            jsonObject.put("DeviceName", d.getDeviceName());
            jsonObject.put("DevicePrice", d.getDevicePrice());
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
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }

    public void findDeviceById() throws IOException {
        String deviceId = request.getParameter("deviceId");
        Device dev = deviceDao.findDeviceById(new Integer(deviceId));
        List<Device> list = new ArrayList<Device>();
        list.add(dev);
        makeJson(list);
        //return "success";
    }
}
