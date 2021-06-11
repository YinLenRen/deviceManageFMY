package org.dao;

import org.model.Shopingorder;

import java.util.List;

public interface ShopingorderDao {
    List<Shopingorder> findAllShopingorder();
    Shopingorder findShopingorderById(int shopingorderId);
    List<Shopingorder> findShopingorderByUserId(int userId);
    void addShopingorder(Shopingorder shopingorder);
    void deleteShopingorder(Shopingorder shopingorder);
}
