package org.dao;

import org.model.Deviceclass;

import java.util.List;

public interface DeviceClassDao {
    List<Deviceclass> findAllDeviceClass();
    Deviceclass findDeviceClass(int deviceClassId);
    void deleteDeviceClass(Deviceclass deviceClass);
    void editDeviceClass(Deviceclass deviceClass);
    void addDeviceClass(Deviceclass deviceclass);
}
