package org.dao;

import org.model.Shopingorderitem;

import java.util.List;

public interface ShopingorderitemDao {
    List<Shopingorderitem> findAllShopingorderitem();
    Shopingorderitem findShopingorderitemById(int shopingorderitemId);
    List<Shopingorderitem> findShopingorderitemByShopingorderId(int shopingorderId);
    void addShopingorderitem(Shopingorderitem shopingorderitem);
    void deleteShopingorderitem(Shopingorderitem shopingorderitem);
    void updateShoppingorderitem(Shopingorderitem shopingorderitem);
}
