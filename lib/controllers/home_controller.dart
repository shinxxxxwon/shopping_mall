
import 'package:get/get.dart';

class HomeController extends GetxController{
  int tabsButtonState = 0;

  void changeTabsButtonState(int state){
    tabsButtonState = state;
    update();
  }

}