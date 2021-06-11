package org.dao.imp;

import org.dao.ShopingorderDao;
import org.model.Shopingorder;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class ShopingorderDaoImp extends HibernateDaoSupport implements ShopingorderDao {
    @Override
    public List<Shopingorder> findAllShopingorder() {
        List<Shopingorder> list = getHibernateTemplate().find("from Shopingorder");
        return list;
    }

    @Override
    public Shopingorder findShopingorderById(int shopingorderId) {
        List<Shopingorder> list = getHibernateTemplate().find("from Shopingorder where shopingOrderId = ?", shopingorderId);
        return (Shopingorder)list.get(0);
    }

    @Override
    public List<Shopingorder> findShopingorderByUserId(int userId) {
        List<Shopingorder> list = getHibernateTemplate().find("from Shopingorder where user.id = ?",userId);
        return list;
    }

    @Override
    public void addShopingorder(Shopingorder shopingorder) {
        getHibernateTemplate().save(shopingorder);
    }

    @Override
    public void deleteShopingorder(Shopingorder shopingorder) {
        getHibernateTemplate().delete(shopingorder);
    }
}
