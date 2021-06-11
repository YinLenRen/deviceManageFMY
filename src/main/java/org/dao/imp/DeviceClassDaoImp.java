package org.dao.imp;

import org.dao.DeviceClassDao;
import org.model.Deviceclass;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.ArrayList;
import java.util.List;

public class DeviceClassDaoImp extends HibernateDaoSupport implements DeviceClassDao {

    public DeviceClassDaoImp() {
    }

    @Override
    public List<Deviceclass> findAllDeviceClass() {
        List<Deviceclass> list = getHibernateTemplate().find("from org.model.Deviceclass");
        return list;
    }

    @Override
    public Deviceclass findDeviceClass(int deviceClassId) {
        List<Deviceclass> list = this.getHibernateTemplate().find("from Deviceclass where deviceClassId=?", deviceClassId);
        Deviceclass dc = list.get(0);
        return dc;
    }

    @Override
    public void deleteDeviceClass(Deviceclass deviceClass) {
        getHibernateTemplate().delete(deviceClass);
    }

    @Override
    public void editDeviceClass(Deviceclass deviceclass) {
        getHibernateTemplate().update(deviceclass);
    }

    @Override
    public void addDeviceClass(Deviceclass deviceclass) {
        getHibernateTemplate().save(deviceclass);
    }
}
