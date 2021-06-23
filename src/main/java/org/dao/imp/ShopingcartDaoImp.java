package org.dao.imp;

import org.dao.ShopingcartDao;
import org.dao.ShopingorderDao;
import org.dao.ShopingorderitemDao;
import org.model.Device;
import org.model.Shopingcart;
import org.model.Shopingorder;
import org.model.Shopingorderitem;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class ShopingcartDaoImp extends HibernateDaoSupport implements ShopingcartDao {



    @Override
    public List<Shopingcart> findAllShopingcart() {
        List<Shopingcart> list = getHibernateTemplate().find("from Shopingcart");
        return list;
    }

    @Override
    public Shopingcart findShopingcartById(int ShopingcartId) {
        List<Shopingcart> list = getHibernateTemplate().find("from Shopingcart where shopingcartId = ?", ShopingcartId);
        return (Shopingcart) list.get(0);
    }

    @Override
    public void addShopingcart(Shopingcart shopingcart) {
        getHibernateTemplate().save(shopingcart);
    }

    @Override
    public void deleteShopingcart(Shopingcart shopingcart) {
        getHibernateTemplate().delete(shopingcart);
    }

    @Override
    public List<Shopingcart> findShopingcartByUserId(int userId) {
        List<Shopingcart> list = getHibernateTemplate().find("from Shopingcart where user.id = ?", userId);
        return list;
    }

    private ShopingorderDao shopingorderDao;
    public void setShopingorderDao(ShopingorderDao shopingorderDao) {
        this.shopingorderDao = shopingorderDao;
    }

    private ShopingorderitemDao shopingorderitemDao;
    public void setShopingorderitemDao(ShopingorderitemDao shopingorderitemDao) {
        this.shopingorderitemDao = shopingorderitemDao;
    }

    @Override
    public void calulation(Shopingorder shopingorder, List<Shopingcart> list) {
        //添加订单及订单项
        shopingorderDao.addShopingorder(shopingorder);

        for(Shopingcart sc : list){
            Shopingorderitem it = new Shopingorderitem();
            Device de = sc.getDevice();
            it.setDevice(de);
            it.setBuyNum(sc.getBuyNum());
            it.setShopingorder(shopingorder);
            shopingorderitemDao.addShopingorderitem(it);
        }
        for(Shopingcart sc : list){
            deleteShopingcart(sc);
        }
    }

    @Override
    public void updateShoppingcart(Shopingcart shopingcart) {
        getHibernateTemplate().update(shopingcart);
    }
}
