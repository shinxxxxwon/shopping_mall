
import 'package:get/get.dart';
import 'package:shopping_mall/models/user/user_model.dart';

class UserController extends GetxController{
  UserModel? userInfo;

  void getUserInfo(UserModel userData){
    userInfo = userData;
    update();
  }

}