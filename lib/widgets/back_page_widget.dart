import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackPageWidget extends StatelessWidget {
  final String? text;
  final Color? color;
  const BackPageWidget({Key? key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.05,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: color!,
              size: size.width * 0.07,
            ),
          ),

          SizedBox(width: size.width * 0.05),

          Text(
            text!,
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
