package org.model;

import java.util.Set;

public class Shopingorder {
    private Integer shopingOrderId;
    private String receiver;
    private String receiveAddress;
    private String createtime;
    private String moneyAmount;
    private User user;
    private Set<Shopingorderitem> shopingorderitems;

    public Integer getShopingOrderId() {
        return shopingOrderId;
    }

    public void setShopingOrderId(Integer shopingOrderId) {
        this.shopingOrderId = shopingOrderId;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getReceiveAddress() {
        return receiveAddress;
    }

    public void setReceiveAddress(String receiveAddress) {
        this.receiveAddress = receiveAddress;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public String getMoneyAmount() {
        return moneyAmount;
    }

    public void setMoneyAmount(String moneyAmount) {
        this.moneyAmount = moneyAmount;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Shopingorder that = (Shopingorder) o;

        if (shopingOrderId != null ? !shopingOrderId.equals(that.shopingOrderId) : that.shopingOrderId != null)
            return false;
        if (receiver != null ? !receiver.equals(that.receiver) : that.receiver != null) return false;
        if (receiveAddress != null ? !receiveAddress.equals(that.receiveAddress) : that.receiveAddress != null)
            return false;
        if (createtime != null ? !createtime.equals(that.createtime) : that.createtime != null) return false;
        if (moneyAmount != null ? !moneyAmount.equals(that.moneyAmount) : that.moneyAmount != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = shopingOrderId != null ? shopingOrderId.hashCode() : 0;
        result = 31 * result + (receiver != null ? receiver.hashCode() : 0);
        result = 31 * result + (receiveAddress != null ? receiveAddress.hashCode() : 0);
        result = 31 * result + (createtime != null ? createtime.hashCode() : 0);
        result = 31 * result + (moneyAmount != null ? moneyAmount.hashCode() : 0);
        return result;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Set<Shopingorderitem> getShopingorderitems() {
        return shopingorderitems;
    }

    public void setShopingorderitems(Set<Shopingorderitem> shopingorderitems) {
        this.shopingorderitems = shopingorderitems;
    }
}
