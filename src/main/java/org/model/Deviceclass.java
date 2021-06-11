package org.model;

import java.util.Set;

public class Deviceclass {
    private Integer deviceClassId;
    private String deviceClassName;
    private Set<Device> devices;

    public Integer getDeviceClassId() {
        return deviceClassId;
    }

    public void setDeviceClassId(Integer deviceClassId) {
        this.deviceClassId = deviceClassId;
    }

    public String getDeviceClassName() {
        return deviceClassName;
    }

    public void setDeviceClassName(String deviceClassName) {
        this.deviceClassName = deviceClassName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Deviceclass that = (Deviceclass) o;

        if (deviceClassId != null ? !deviceClassId.equals(that.deviceClassId) : that.deviceClassId != null)
            return false;
        if (deviceClassName != null ? !deviceClassName.equals(that.deviceClassName) : that.deviceClassName != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = deviceClassId != null ? deviceClassId.hashCode() : 0;
        result = 31 * result + (deviceClassName != null ? deviceClassName.hashCode() : 0);
        return result;
    }

    public Set<Device> getDevices() {
        return devices;
    }

    public void setDevices(Set<Device> devices) {
        this.devices = devices;
    }
}
