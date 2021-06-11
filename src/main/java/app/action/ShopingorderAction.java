package app.action;

import java.io.IOException;

public interface ShopingorderAction {
    void findAllShopingorder() throws IOException;
    void findShopingorderById() throws IOException;
    void findShopingorderByUserId() throws IOException;
    String addShopingorder();
    String deleteShopingorder();
}
