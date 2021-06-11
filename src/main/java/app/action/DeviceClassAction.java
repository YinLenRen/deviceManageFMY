package app.action;

import java.io.IOException;

public interface DeviceClassAction {
    void findAllDeviceClass() throws IOException;
    void findDeviceClass() throws IOException;
    void deleteDeviceClass();
    void editDeviceClass();
    void addDeviceClass();
}
