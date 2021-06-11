package org.dao.imp;

import org.dao.DeviceClassDao;
import org.dao.DeviceDao;
import org.hibernate.SQLQuery;
import org.model.Device;
import org.model.Deviceclass;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.ArrayList;
import java.util.List;

public class DeviceDaoImp extends HibernateDaoSupport implements DeviceDao {

    public DeviceDaoImp() {
    }

    @Override
    public List<Device> findAllDevice() {
        List<Device> list = getHibernateTemplate().find("from Device");
        return list;
    }

    @Override
    public List<Device> findDeviceByDeviceClassId(int deviceClassId) {
        List<Device> list = getHibernateTemplate().find("from Device where deviceclass.deviceClassId = ?", deviceClassId);
        return list;
    }

    @Override
    public Device findDeviceById(int deviceId) {
        List<Device> list = getHibernateTemplate().find("from Device where deviceId = ?", deviceId);
        return (Device)list.get(0);
    }

    @Override
    public List<Device> findDeviceByName(String deviceName) {
        List<Device> list = getHibernateTemplate().find("from Device where deviceName like '%" + deviceName + "%'");
        return list;
    }

    @Override
    public List<Device> findDeviceByPrice(String low, String high) {
        List<Device> list = getHibernateTemplate().find("from Device where devicePrice between "+ low + " and " + high);
        return list;
    }

    @Override
    public List<Device> findDeviceByFuzzy(String deviceClassName, String deviceName, String low, String high) {
        String hql = "from Device where deviceName like '%" + deviceName + "%' and devicePrice between " + low + " and " + high;
        List<Device> preList = getHibernateTemplate().find(hql);
        List<Device> finalList = new ArrayList<Device>();
        for(Device d : preList){
            String hql1 = "from Deviceclass where deviceClassId =" + d.getDeviceclass().getDeviceClassId() +
                    " and deviceClassName like '%" + deviceClassName + "%'";
            List<Deviceclass> dcList = getHibernateTemplate().find(hql1);
           if(dcList != null) d.setDeviceclass(dcList.get(0));
            if(dcList != null) finalList.add(d);
        }
        return finalList;
    }

    @Override
    public void updateDeviceById(int deviceId, String deviceName, String devicePrice) {
        Device de = findDeviceById(deviceId);
        de.setDeviceName(deviceName);
        de.setDevicePrice(devicePrice);
        getHibernateTemplate().update(de);
    }

    @Override
    public List<Device> findDeviceByFuzzyWay1(String deviceClassName, String deviceName, String low, String high) {
        String hql1 = "from Device where deviceName like '%" + deviceName + "%' and devicePrice between " + low + " and " + high;
        List<Device> preList = getHibernateTemplate().find(hql1);
        List<Device> finalList = new ArrayList<Device>();
        for(Device d :preList){
            String hql2 = "from Deviceclass where deviceClassId = " + d.getDeviceclass().getDeviceClassId() +
                    " and deviceClassName like '%" + deviceClassName + "%'";
            List<Deviceclass> list = getHibernateTemplate().find(hql2);
            if(list != null && list.size() > 0) d.setDeviceclass(list.get(0));
            if(list != null) finalList.add(d);
        }
        return finalList;
    }

    @Override
    public List<Device> findDeviceByFuzzyWay2(String deviceClassName, String deviceName, String low, String high) {
        String hql1 = "from Deviceclass where deviceClassName = '%" + deviceClassName + "%'";
        List<Deviceclass> preList = getHibernateTemplate().find(hql1);
        List<Device> finalList = new ArrayList<Device>();
        for(Deviceclass dc : preList) {
            for (Device d : dc.getDevices()) {
                String hql2 = "from Device where deviceId = " + d.getDeviceId() +
                        "and deviceName like '%" + deviceName +
                        "%' and devicePrice between" + low + "and" + high;
                List<Device> list = getHibernateTemplate().find(hql2);
                if (list != null) finalList.add(d);
            }

        }
        return finalList;
    }

    @Override
    public List<Device> findDeviceByFuzzyWay3(String deviceClassName, String deviceName, String low, String high) {
        String hql = "from Device where deviceclass.deviceClassId IN(SELECT deviceClassId from Deviceclass where deviceClassName like '%" + deviceClassName + "%') and deviceName like '%" + deviceName + "%' and devicePrice between " + low + " and " + high;
        List<Device> list = getHibernateTemplate().find(hql);
        return list;
    }

    @Override
    public List<Device> findDeviceByFuzzyWay4(String deviceClassName, String deviceName, String low, String high) {
        SQLQuery sqlQuery = getSession().createSQLQuery(
          "SELECT * from Device INNER JOIN Deviceclass ON(Device.deviceId=Deviceclass.deviceClassId " + "and Device.deviceName like '%" + deviceName + "%' and Deviceclass.deviceClassName like '%"+ deviceClassName + "%' and Device.devicePrice between " + low + " and " + high + ")");
          //  "SELECT * from Device INNER JOIN Deviceclass ON(Device.deviceId=Deviceclass.deviceClassId " + "and Device.deviceName like '%" + deviceName + "%' and Deviceclass.deviceClassName like '%"+ deviceClassName + "%' and Device.devicePrice between " + low + " and "+ high + ")");
        List<Device> list =  sqlQuery.list();
        return list;
    }



    @Override
    public void addDevice(Device device) {

     /*  Deviceclass deviceclass = deviceClassDao.findDeviceClass(deviceClassId);
        device.setDeviceclass(deviceclass);*/
        getHibernateTemplate().save(device);

    }

    @Override
    public void deleteDevice(Device device) {
        getHibernateTemplate().delete(device);
    }

    @Override
    public void editDevice(Device device) {
        getHibernateTemplate().update(device);
    }

}
