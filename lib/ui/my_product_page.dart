import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/controllers/product_controller.dart';
import 'package:shopping_mall/models/product/product_model.dart';
import 'package:shopping_mall/ui/product_detail_page.dart';
import 'package:shopping_mall/ui/product_registration_page.dart';
import 'package:shopping_mall/widgets/back_page_widget.dart';
import 'package:shopping_mall/widgets/text_widget.dart';

class MyProductPage extends StatefulWidget {
  final String? userId;
  const MyProductPage({Key? key, this.userId}) : super(key: key);

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {


  Widget _productsView(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    final format = NumberFormat('###,###');

    return GetBuilder<ProductController>(
      builder: (controller){
        return Container(
          width: size.width,
          height: size.height * 0.73,
          // margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
          alignment: Alignment.center,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1/1.5,
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onLongPress: (){
                  _deleteProduct(size, controller.products[index]);
                },
                onTap: () => Get.to(ProductDetailPage(product: controller.products[index], isMy: true,)),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Column(
                    children: <Widget>[

                      Expanded(
                          flex: 4,
                          child: SizedBox(
                            width: size.width,
                            child: Image.network(
                              controller.products[index].images!,
                              fit: BoxFit.fill,
                            ),
                          )
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            controller.products[index].title!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.06,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${format.format(controller.products[index].price!)}원',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
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

          BackPageWidget(text: '등록상품'),

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

  _deleteProduct(Size size, ProductModel product){

    String title = "상품을 삭제하시겠습니까?";
    String btnText = "상품 제거하기";


    Platform.isAndroid
        ? showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: size.height * 0.2,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  child: Text(title),
                ),

                Divider(),

                GestureDetector(
                  onTap: (){
                    firebaseController.deleteProduct(product);
                    Get.back();
                  },
                  child: Container(
                    height: size.height * 0.1,
                    alignment: Alignment.center,
                    child: Text(
                      btnText,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    )
        : showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(title),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              firebaseController.deleteProduct(product);
              Get.back();
            },
            child: Text(btnText),
          ),
        ],
      ),
    );
  }
}
