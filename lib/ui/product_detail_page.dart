import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopping_mall/controllers/cart_controller.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/models/product/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel? product;
  final bool? isMy;

  const ProductDetailPage({Key? key, this.product, this.isMy}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isDone = false;
  final format = NumberFormat('###,###');

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

          Expanded(
            child: _isDone ?
                Text(
                  '상품이 추가되었습니다.',
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: Colors.black,
                  ),
                ) :
                const SizedBox(),
          ),

          widget.isMy == false ?
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async{
                  await firebaseController.insertCart(widget.product!.key!);
                  setState(() {
                    _isDone = true;
                  });
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: size.width * 0.08,
                ),
              ),
            ),
          ) : const SizedBox(),

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
            widget.product!.images!,
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
        widget.product!.title!,
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
        '${format.format(widget.product!.price!)}원',
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
        strutStyle: const StrutStyle(fontSize: 16.0),
        text: TextSpan(
          text: widget.product!.info!,
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

    return GestureDetector(
      onTap: (){
        Platform.isAndroid
            ? showMaterialModalBottomSheet(
            duration: const Duration(milliseconds: 500),
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            builder: (context){
              return _bottomSheetView(size);
            }
        )
            : showCupertinoModalBottomSheet(
            context: context,
            duration: const Duration(milliseconds: 500),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            builder: (context){
              return _bottomSheetView(size);
            }
        );
      },
      child: Container(
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
      ),
    );
  }


  Widget _bottomSheetView(Size size){
    final marginWidth = size.width * 0.05;

    return SizedBox(
      width: size.width,
      height: size.height * 0.2,
      child: Column(
        children: <Widget>[

          SizedBox(height: size.height * 0.03),

          Container(
            width: size.width,
            height: size.height * 0.05,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: marginWidth, right: marginWidth),
            child: Text(
              widget.product!.title!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.04,
              ),
            ),
          ),

          Container(
            width: size.width,
            height: size.height * 0.05,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: marginWidth, right: marginWidth),
            child: Text(
              '${format.format(widget.product!.price!)}원',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.05,
              ),
            ),
          ),

          Container(
            width: size.width,
            height: size.height * 0.05,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: marginWidth, right: marginWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.red,
            ),
            child: Text(
              '구매하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
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

          widget.isMy! == false ? _okButton(size) : const SizedBox(),

        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Platform.isAndroid
        ? MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: SafeArea(
          child: _pageView(size),
        ),
      ),
    )
        : CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoPageScaffold(
        child: SafeArea(
          child: _pageView(size),
        ),
      ),
    );
  }

  void startTimer() {
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _isDone = false;
        });
      });
  }
}

