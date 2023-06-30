import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/home_controller.dart';

class TabsButtonWidget extends StatefulWidget {
  final int? type;
  final String? text;
  final IconData? icon;

  TabsButtonWidget({Key? key, this.type, this.text, this.icon}) : super(key: key);

  @override
  State<TabsButtonWidget> createState() => _TabsButtonWidgetState();
}

class _TabsButtonWidgetState extends State<TabsButtonWidget> {
  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;

    final marginWidth = size.width * 0.05;
    final marginHeight = size.height * 0.01;

    return GetBuilder<HomeController>(
      builder: (controller){
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
            padding: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              color: Get.find<HomeController>().tabsButtonState == widget.type! ? Colors.white : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Icon(
                  widget.icon!,
                  color: Get.find<HomeController>().tabsButtonState == widget.type! ? Colors.blueGrey : Colors.white,
                  size: size.width * 0.1,
                ),

                Text(
                  Get.find<HomeController>().tabsButtonState == widget.type! ? widget.text! : "",
                  style: TextStyle(
                    color: Get.find<HomeController>().tabsButtonState == widget.type! ? Colors.blueGrey : Colors.white,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
