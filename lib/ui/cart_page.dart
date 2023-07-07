import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_mall/controllers/cart_controller.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/widgets/back_page_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final format = NumberFormat('###,###');

  Widget _cartView(Size size){
    return FutureBuilder(
      future: _loadData(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else{
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: GetBuilder<CartController>(
              builder: (controller){
                return ListView.builder(
                  itemCount: controller.cartProduct.length,
                  itemBuilder: (context, index){
                    return Container(
                      width: size.width,
                      height: size.height * 0.15,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Image.network(
                                controller.cartProduct[index].images.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 4,
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(
                                  controller.cartProduct[index].title.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.05,
                                    color: Colors.black,
                                  ),
                                ),

                                Text(
                                  '${format.format(controller.cartProduct[index].price)}원',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 0.05,
                                    color: Colors.black,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){},
                                  child: Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    margin: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.red,
                                    ),
                                    child: Text(
                                      '구매하기',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.width * 0.04,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _pageView(Size size){
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[

          Expanded(
            flex: 1,
            child: BackPageWidget(text: '장바구니'),
          ),

          Expanded(
            flex: 10,
            child: _cartView(size),
          ),

        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _loadData() async{
    await firebaseController.getCart();
    await firebaseController.getCartProduct();
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

