
import 'package:get/get.dart';
import 'package:shopping_mall/models/cart/cart_model.dart';
import 'package:shopping_mall/models/product/product_model.dart';

class CartController extends GetxController{
  CartModel? carts;
  List<ProductModel> cartProduct = [];

  getCartProduct(List<ProductModel> list){
    cartProduct = list;
    update();
  }

  getCarts(CartModel cart){
    carts = cart;
    update();
  }

  deleteCart(String productKey){
    // carts.key!.remove(productKey);
    update();
  }
}