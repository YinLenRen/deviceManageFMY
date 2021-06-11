package org.dao.imp;

import org.dao.ShopingorderitemDao;
import org.model.Shopingorderitem;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class ShopingorderitemDaoImp extends HibernateDaoSupport implements ShopingorderitemDao {
    @Override
    public List<Shopingorderitem> findAllShopingorderitem() {
        List<Shopingorderitem> list = getHibernateTemplate().find("from Shopingorderitem");
        return list;
    }

    @Override
    public Shopingorderitem findShopingorderitemById(int shopingorderitemId) {
        List<Shopingorderitem> list = getHibernateTemplate().find("from Shopingorderitem where shopingOrderItemId = ?", shopingorderitemId);
        return (Shopingorderitem) list.get(0);
    }

    @Override
    public List<Shopingorderitem> findShopingorderitemByShopingorderId(int shopingorderId) {
        List<Shopingorderitem> list = getHibernateTemplate().find("from org.model.Shopingorderitem where shopingorder.shopingOrderId = ?", shopingorderId);
        return  list;
    }

    @Override
    public void addShopingorderitem(Shopingorderitem shopingorderitem) {
        getHibernateTemplate().save(shopingorderitem);
    }

    @Override
    public void deleteShopingorderitem(Shopingorderitem shopingorderitem) {
        getHibernateTemplate().delete(shopingorderitem);
    }

    @Override
    public void updateShoppingorderitem(Shopingorderitem shopingorderitem) {
        getHibernateTemplate().update(shopingorderitem);
    }
}
