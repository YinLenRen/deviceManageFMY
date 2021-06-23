package org.dao;

import org.model.Shopingcart;
import org.model.Shopingorder;

import java.util.List;

public interface ShopingcartDao {
    List<Shopingcart> findAllShopingcart();
    Shopingcart findShopingcartById(int ShopingcartId);
    void addShopingcart(Shopingcart shopingcart);
    void deleteShopingcart(Shopingcart shopingcart);
    List<Shopingcart> findShopingcartByUserId(int userId);
    void calulation(Shopingorder shopingorder, List<Shopingcart> list);
    void updateShoppingcart(Shopingcart shopingcart);
}

