import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final Alignment? alignment;
  final double? textSize;
  final Color? color;

  const TextWidget({Key? key, this.text, this.alignment, this.textSize, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final marginWidth = size.width * 0.05;
    final marginHeight = size.height * 0.02;

    return Container(
      width: size.width,
      height: size.height * 0.05,
      alignment: alignment ?? Alignment.center,
      margin : EdgeInsets.only(left: marginWidth, right: marginWidth),
      child: Text(
        text!,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: textSize!
        ),
      ),
    );
  }
}
