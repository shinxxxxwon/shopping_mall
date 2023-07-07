import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_mall/controllers/product_controller.dart';
import 'package:shopping_mall/ui/product_detail_page.dart';
import 'package:shopping_mall/widgets/back_page_widget.dart';

class ProductPage extends StatefulWidget {
  final bool? isBrand;
  final int? brand;
  final int? category;
  const ProductPage({Key? key, this.category, this.brand, this.isBrand}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  Widget _backPage(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;
    String title = "";

    if(widget.isBrand!){
      if(widget.brand == 0){
        title = "CUCCI";
      }
      else if(widget.brand == 1){
        title = "BERBURY";
      }
      else if(widget.brand == 2){
        title = "Louis Vuitton";
      }
      else if(widget.brand == 3){
        title = "CHANNEL";
      }
      else{
        title = "PRADA";
      }
    }
    else{
      if(widget.category == 0){
        title = "Cloths";
      }
      else if(widget.category == 1){
        title = "Bags";
      }
      else{
        title = "Shoose";
      }
    }
    return BackPageWidget(text: title);
  }

  Widget _productView(Size size){
    final format = NumberFormat('###,###');

    return GetBuilder<ProductController>(
      builder: (controller){
        return Container(
          width: size.width,
          height: size.height * 0.85,
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
                  // _deleteProduct(size, controller.products[index]);
                },
                onTap: () => Get.to(ProductDetailPage(product: controller.products[index], isMy: false)),
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

  Widget _pageView(Size size){
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[

          _backPage(size),

          _productView(size),

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
