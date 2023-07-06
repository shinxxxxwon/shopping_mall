import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_mall/models/product/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel? product;
  final bool? isMy;

  const ProductDetailPage({Key? key, this.product, this.isMy}) : super(key: key);

  Widget _backPage(Size size){
    final marginHeight = size.height * 0.01;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.05,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
      child: Row(
        children: <Widget>[

          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: size.width * 0.08,
                ),
              ),
            ),
          ),

          isMy == false ?
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: size.width * 0.08,
                ),
              ),
            ),
          ) : SizedBox(),

        ],
      ),
    );
  }

  Widget _productImage(Size size){
    final marginHeight = size.height * 0.01;

    return Container(
      width: size.width,
      height: size.height * 0.3,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: marginHeight, bottom: marginHeight),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            product!.images!,
          ),
        ),
      ),
    );
  }

  Widget _titleText(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.05,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: marginHeight),
      child: Text(
        product!.title!,
        style: TextStyle(
          fontSize: size.width * 0.07,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _priceText(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    final format = NumberFormat('###,###');

    return Container(
      width: size.width,
      height: size.height * 0.05,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: marginHeight),
      child: Text(
        '${format.format(product!.price!)}원',
        style: TextStyle(
          fontSize: size.width * 0.05,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _infoText(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.3,
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
        strutStyle: StrutStyle(fontSize: 16.0),
        text: TextSpan(
          text: product!.info!,
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _okButton(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.08,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.red
      ),
      child: Text(
        '구매하기',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: size.width * 0.06,
        ),
      ),
    );
  }

  Widget _pageView(Size size){
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[

          _backPage(size),

          _productImage(size),

          _titleText(size),

          _priceText(size),

          _infoText(size),

          isMy! == false ? _okButton(size) : SizedBox(),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Platform.isAndroid
        ? MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: _pageView(size),
        ),
      ),
    )
        : CupertinoApp(
      home: CupertinoPageScaffold(
        child: SafeArea(
          child: _pageView(size),
        ),
      ),
    );
  }
}
