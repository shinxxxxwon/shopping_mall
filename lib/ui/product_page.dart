import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/controllers/product_controller.dart';
import 'package:shopping_mall/ui/product_registration_page.dart';
import 'package:shopping_mall/widgets/text_widget.dart';

class ProductPage extends StatefulWidget {
  final String? userId;
  const ProductPage({Key? key, this.userId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  Widget _backPage(Size size){
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
              color: Colors.black,
              size: size.width * 0.07,
            ),
          ),

          SizedBox(width: size.width * 0.05),

          Text(
            '등록상품',
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

  Widget _productsView(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return GetBuilder<ProductController>(
      builder: (controller){
        return Container(
          width: size.width,
          height: size.height * 0.7,
          margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
          alignment: Alignment.center,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1/1.5,
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index){
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Column(
                  children: <Widget>[

                    Text(
                      controller.products[index].title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),

                    Text(
                      controller.products[index].price!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.04,
                      ),
                    ),

                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _okButton(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return GestureDetector(
      onTap: (){
        Get.to(ProductRegistrationPage(userId: widget.userId!));
      },
      child: Container(
        width: size.width,
        height: size.height * 0.08,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          '상품 등록',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: size.width * 0.06,
          ),
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

          _productsView(size),

          _okButton(size),

        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseController.getMyProductData(widget.userId!);
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
