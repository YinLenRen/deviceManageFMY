package app.action;

import java.io.IOException;

public interface ShopingcartAction {
    void findAllShopingcart() throws IOException;
    void findShopingcartById() throws IOException;
    void findAllShopingcartByUserId() throws IOException;
    String  addShopingcart();
    String deleteShopingcart();
    String calulation();
    void updateShoppingcart();
}
