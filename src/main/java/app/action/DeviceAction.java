package app.action;

import java.io.IOException;

public interface DeviceAction {
    void findAllDevice() throws IOException;
    void findDeviceByDeviceClassId() throws IOException;
    void findDeviceById() throws IOException;
    void findDeviceByName() throws IOException;
    void findDeviceByPrice() throws IOException;
    void findDeviceByFuzzy() throws IOException;
    void updateDeviceById() throws IOException;

    void addDevice();
    void deleteDevice();
    void editDevice();

}
