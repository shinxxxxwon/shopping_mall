import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MenuWidget extends StatefulWidget {
  final IconData? iconData;
  final String? label;
  final int? type;

  const MenuWidget({Key? key, this.iconData, this.type, this.label}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final marginHeight = size.height * 0.01;
    final marginWidth = size.width * 0.05;

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Icon(widget.iconData!, color: Colors.white, size: size.width * 0.06,),

            SizedBox(height: size.width * 0.01,),

            Text(
              widget.label!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.04,
              ),
            )

          ],
        ),
      ),
    );
  }
}