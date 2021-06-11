package org.model;

import java.util.Set;

public class Device {
    private Integer deviceId;
    private String deviceName;
    private String devicePrice;
    private Deviceclass deviceclass;
    private Set<Shopingcart> shopingcarts;
    private Set<Shopingorderitem> shopingorderitems;

    public Integer getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Integer deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getDevicePrice() {
        return devicePrice;
    }

    public void setDevicePrice(String devicePrice) {
        this.devicePrice = devicePrice;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Device device = (Device) o;

        if (deviceId != null ? !deviceId.equals(device.deviceId) : device.deviceId != null) return false;
        if (deviceName != null ? !deviceName.equals(device.deviceName) : device.deviceName != null) return false;
        if (devicePrice != null ? !devicePrice.equals(device.devicePrice) : device.devicePrice != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = deviceId != null ? deviceId.hashCode() : 0;
        result = 31 * result + (deviceName != null ? deviceName.hashCode() : 0);
        result = 31 * result + (devicePrice != null ? devicePrice.hashCode() : 0);
        return result;
    }

    public Deviceclass getDeviceclass() {
        return deviceclass;
    }

    public void setDeviceclass(Deviceclass deviceclass) {
        this.deviceclass = deviceclass;
    }

    public Set<Shopingcart> getShopingcarts() {
        return shopingcarts;
    }

    public void setShopingcarts(Set<Shopingcart> shopingcarts) {
        this.shopingcarts = shopingcarts;
    }

    public Set<Shopingorderitem> getShopingorderitems() {
        return shopingorderitems;
    }

    public void setShopingorderitems(Set<Shopingorderitem> shopingorderitems) {
        this.shopingorderitems = shopingorderitems;
    }
}
