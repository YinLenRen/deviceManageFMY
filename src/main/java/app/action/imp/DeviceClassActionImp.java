package app.action.imp;

import app.action.DeviceClassAction;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.dao.DeviceClassDao;
import org.model.Deviceclass;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class DeviceClassActionImp extends ActionSupport implements DeviceClassAction, ServletRequestAware, ServletResponseAware {

    private HttpServletRequest request;
    private HttpServletResponse response;

    private DeviceClassDao deviceClassDao;

    public void setDeviceClassDao(DeviceClassDao deviceClassDao) {
        this.deviceClassDao = deviceClassDao;
    }

    @Override
    public void findAllDeviceClass() throws IOException {
        List<Deviceclass> list = new ArrayList<Deviceclass>();
        list = deviceClassDao.findAllDeviceClass();
        makeJson(list);
    }

    @Override
    public void findDeviceClass() throws IOException {
        String id = request.getParameter("deviceClassId");
        Deviceclass dc = deviceClassDao.findDeviceClass(new Integer(id));
        List<Deviceclass> list = new ArrayList<Deviceclass>();
        list.add(dc);
        makeJson(list);  //调用该方法，在页面显示result
    }

    @Override
    public void deleteDeviceClass() {
        String id = request.getParameter("deviceClassId");
        deviceClassDao.deleteDeviceClass(deviceClassDao.findDeviceClass(new Integer(id)));
    }

    @Override
    public void editDeviceClass() {
        String id = request.getParameter("deviceClassId");
        String name = request.getParameter("deviceClassName");
        Deviceclass deviceclass = new Deviceclass();
        deviceclass.setDeviceClassId(new Integer(id));
        deviceclass.setDeviceClassName(name);
        deviceClassDao.editDeviceClass(deviceclass);
    }

    @Override
    public void addDeviceClass() {
        String id = request.getParameter("deviceClassId");
        String name = request.getParameter("deviceClassName");
        Deviceclass deviceclass = new Deviceclass();
        deviceclass.setDeviceClassName(name);
        deviceclass.setDeviceClassId(new Integer(id));
        deviceClassDao.addDeviceClass(deviceclass);
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }

    void makeJson(List<Deviceclass> list) throws IOException {
        response.setHeader("Content-Type", "text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONArray jsonArray = new JSONArray();

        //JSONArray是json数组， JSONObject是json
        for(Deviceclass dc : list){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("DeviceClassID", dc.getDeviceClassId());
            jsonObject.put("DeviceClassName", dc.getDeviceClassName());
            jsonArray.add(jsonObject);
        }
        System.out.println(jsonArray.toString());
        JSONObject root = new JSONObject();
        root.put("result", jsonArray);
        out.write(root.toString());
        out.flush();
        out.close();
    }



}
