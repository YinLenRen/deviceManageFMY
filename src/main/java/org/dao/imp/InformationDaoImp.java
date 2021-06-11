package org.dao.imp;

import org.dao.InformationDao;
import org.model.Information;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class InformationDaoImp extends HibernateDaoSupport implements InformationDao {

    public InformationDaoImp() {
    }

    @Override
    public void addInformation(Information info) {

        getHibernateTemplate().save(info);
    }


    @Override
    public List<Information> findAllInformation() {
        List<Information> list = getHibernateTemplate().find("from Information");
        return list;
    }

    @Override
    public Information findInformationById(int infoId) {
        List<Information> list = getHibernateTemplate().find("from Information where informationId = ?", infoId);
        return (Information) list.get(0);
    }

    @Override
    public void deleteInformation(Information information) {
        getHibernateTemplate().delete(information);
    }

    @Override
    public void updateInformation(Information information) {
        getHibernateTemplate().update(information);
    }
}
