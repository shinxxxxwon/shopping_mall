
import 'package:get/get.dart';
import 'package:shopping_mall/models/product/product_model.dart';

class ProductController extends GetxController{
  List<ProductModel> products = [];

  addProduct(ProductModel product){
    products.add(product);
    update();
  }

  getProducts(List<ProductModel> list){
    products = list;
    update();
  }
}