package org.dao;

import org.model.Device;
import org.model.Deviceclass;

import java.util.List;

public interface DeviceDao {
    List<Device> findAllDevice();
    List<Device> findDeviceByDeviceClassId(int deviceClassId);
    Device findDeviceById(int deviceId);
    List<Device> findDeviceByName(String deviceName);
    List<Device> findDeviceByPrice(String low, String high);
    List<Device> findDeviceByFuzzy(String deviceClassName, String deviceName, String low, String high);
    void updateDeviceById(int deviceId, String deviceName, String devicePrice);

    List<Device> findDeviceByFuzzyWay1(String deviceClassName, String deviceName, String low, String high);
    List<Device> findDeviceByFuzzyWay2(String deviceClassName, String deviceName, String low, String high);
    List<Device> findDeviceByFuzzyWay3(String deviceClassName, String deviceName, String low, String high);
    List<Device> findDeviceByFuzzyWay4(String deviceClassName, String deviceName, String low, String high);

    void addDevice(Device device);
    void deleteDevice(Device device);
    void editDevice(Device device);
}
