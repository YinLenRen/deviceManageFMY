package org.model;

public class Shopingorderitem {
    private Integer shopingOrderItemId;
    private Integer buyNum;
    private Shopingorder shopingorder;
    private Device device;

    public Integer getShopingOrderItemId() {
        return shopingOrderItemId;
    }

    public void setShopingOrderItemId(Integer shopingOrderItemId) {
        this.shopingOrderItemId = shopingOrderItemId;
    }

    public Integer getBuyNum() {
        return buyNum;
    }

    public void setBuyNum(Integer buyNum) {
        this.buyNum = buyNum;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Shopingorderitem that = (Shopingorderitem) o;

        if (shopingOrderItemId != null ? !shopingOrderItemId.equals(that.shopingOrderItemId) : that.shopingOrderItemId != null)
            return false;
        if (buyNum != null ? !buyNum.equals(that.buyNum) : that.buyNum != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = shopingOrderItemId != null ? shopingOrderItemId.hashCode() : 0;
        result = 31 * result + (buyNum != null ? buyNum.hashCode() : 0);
        return result;
    }

    public Shopingorder getShopingorder() {
        return shopingorder;
    }

    public void setShopingorder(Shopingorder shopingorder) {
        this.shopingorder = shopingorder;
    }

    public Device getDevice() {
        return device;
    }

    public void setDevice(Device device) {
        this.device = device;
    }
}
