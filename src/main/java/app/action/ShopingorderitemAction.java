package app.action;

import java.io.IOException;

public interface ShopingorderitemAction {
    void findAllShopingorderitem() throws IOException;
    void findShopingorderitemById() throws IOException;
    void findShopingorderitemByShopingorderId() throws IOException;
    String addShopingorderitem();
    String deleteShopingorderitem();
    void updateShoppingorderitem();

}
