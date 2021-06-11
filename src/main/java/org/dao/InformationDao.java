package org.dao;

import org.model.Device;
import org.model.Information;

import javax.swing.*;
import java.util.List;

public interface InformationDao {
    void addInformation(Information info);
    List<Information> findAllInformation();
    Information findInformationById(int infoId);
    void deleteInformation(Information information);
    void updateInformation(Information information);
}
