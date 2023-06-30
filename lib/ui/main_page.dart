import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/home_controller.dart';
import 'package:shopping_mall/controllers/user_controller.dart';
import 'package:shopping_mall/widgets/menu_widget.dart';
import 'package:shopping_mall/widgets/search_widget.dart';
import 'package:shopping_mall/widgets/tabs_button_widget.dart';
import 'package:shopping_mall/widgets/text_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _discoverView(Size size) {
    final marginWidth = size.width * 0.05;
    return Container(
      width: size.width,
      height: size.height * 0.3,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: marginWidth),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/premium-photo/cool-people-posing-together-full-shot_23-2149409769.jpg?w=2000'),
            fit: BoxFit.fill,
          )),
    );
  }

  Widget _brandView(Size size) {
    final marginWidth = size.width * 0.03;
    final marginHeight = size.height * 0.01;

    final List<String> imageUrl = [
      'https://img.freepik.com/premium-photo/pretty-young-woman-trendy-outfit_251859-583.jpg?w=900',
      //cucci
      'https://img.freepik.com/free-photo/portrait-blonde-beautiful-curly-woman-stylish-silk-white-dress-tweed-oversized-jacket-holding-black-leathered-handbag-walking-outdoors_197531-28338.jpg?w=900&t=st=1687931661~exp=1687932261~hmac=03570db078fca93573c7637eed8e014a3540c8f08beea0a4caa9012e3d3b5c95',
      //burbery
      'https://img.freepik.com/free-photo/attractive-stylish-blonde-woman-beige-coat-sitting-suitcases-against-wall-street_285396-8114.jpg?w=2000&t=st=1687932003~exp=1687932603~hmac=1ec2c6653c8914445bec46ad739b3061fe67b91bacc3e7216b9ea28a2a9e324b',
      //Louis Vuitton,
      'https://img.freepik.com/free-photo/young-attractive-girl-trench-coat-blue-shirt-with-backpack-shoulder-dreamily-looking-camera-beige-background-isolated_574295-4669.jpg?w=900&t=st=1687932067~exp=1687932667~hmac=fe51ae27c93d6c1eeb3f43ebbdc769c2207fcfd52ecc02f45be4ccb5bcc2209d',
      //Channel
      'https://img.freepik.com/free-photo/beautiful-young-female-model-posing-front-building_23-2148187397.jpg?w=900&t=st=1687932115~exp=1687932715~hmac=fccab2e82564684bf4fec313ae5ff1d541c24af6fabe54ae7083b88845422a3e',
      //Prada
    ];

    final List<String> brandTitle = [
      'GUCCI',
      'BERBURY',
      'Louis Vuitton',
      'Channel',
      'Prada'
    ];

    return Container(
      width: size.width,
      height: size.height * 0.3,
      padding: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: marginWidth),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4 / 3,
          mainAxisSpacing: marginWidth,
          crossAxisSpacing: marginWidth,
        ),
        itemCount: brandTitle.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            // margin: EdgeInsets.only(left: size.width * 0.01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl[index]),
                fit: BoxFit.fill,
              ),
            ),
            child: Text(
              brandTitle[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: size.width * 0.05,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _categoryView(Size size){
    final marginWidth = size.width * 0.03;

    final List<String> imageUrl = [
      'https://i.pinimg.com/736x/48/9f/2b/489f2b0c7ddd48a7a96ca1a8cc4b3c69.jpg', //Cloths
      'https://i.pinimg.com/736x/c2/34/1e/c2341e1b4ec0e863dbdcd4dbcfb5f0a4.jpg', //Bags,
      'https://i.pinimg.com/564x/e2/35/bf/e235bf15fdb30f605ab6fdeeafa3064e.jpg', //shoose
    ];
    final List<String> categoryTitle = [
      'Cloths',
      'Bags',
      'Shoose',
    ];

    return Container(
      width: size.width,
      height: size.height * 0.4,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          mainAxisSpacing: marginWidth,
          crossAxisSpacing: marginWidth,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index){
          return Container(
            // margin: EdgeInsets.only(left: size.width * 0.01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl[index]),
                fit: BoxFit.fill,
              ),
            ),
            child: Text(
              categoryTitle[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: size.width * 0.05,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _contentsView(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.9,
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: const BoxDecoration(
        color: Color(0xFF595959),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(48.0),
            bottomLeft: Radius.circular(48.0)),
      ),
      child: ListView(
        children: [

          SearchWidget(),

          TextWidget(
            text: 'Discover',
            alignment: Alignment.centerLeft,
            textSize: size.width * 0.06,
          ),

          _discoverView(size),

          TextWidget(
            text: 'Brand Shops',
            alignment: Alignment.centerLeft,
            textSize: size.width * 0.06,
          ),

          _brandView(size),

          TextWidget(
            text: 'Category',
            alignment: Alignment.centerLeft,
            textSize: size.width * 0.06,
          ),

          _categoryView(size),
        ],
      ),
    );
  }

  Widget _myPageMenu(Size size){

    final marginHeight = size.height * 0.05;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.13,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.0),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          MenuWidget(type: 0, iconData: Icons.list_alt, label: '구매내역'),

          MenuWidget(type: 1, iconData: Icons.shopping_cart, label: '장바구니'),

          MenuWidget(type: 2, iconData: Icons.volunteer_activism, label: '등록상품'),

        ],
      ),
    );
  }

  Widget _myPageView(Size size){
    return Container(
      width: size.width,
      height: size.height * 0.9,
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: const BoxDecoration(
        color: Color(0xFF595959),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(48.0),
            bottomLeft: Radius.circular(48.0)),
      ),
      child: GetBuilder<UserController>(
        builder: (controller){
          return Column(
            children: <Widget>[

              SizedBox(height: size.height * 0.1),

              TextWidget(text: '${controller.userInfo!.name}님', alignment: Alignment.centerLeft, textSize: size.width * 0.08,),

              _myPageMenu(size),

            ],
          );
        },
      ),
    );
  }


  Widget _bottomTabs(Size size){
    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          GestureDetector(
            onTap: () => Get.find<HomeController>().changeTabsButtonState(0),
            child: TabsButtonWidget(icon: Icons.home_outlined, text: 'Home', type: 0),
          ),

          GestureDetector(
            onTap: () => Get.find<HomeController>().changeTabsButtonState(1),
            child: TabsButtonWidget(icon: Icons.account_circle_outlined, text: 'My Page', type: 1),
          ),

        ],
      ),
    );
  }

  Widget _pageView(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: const Color(0xFF202020),
      child: Column(
        children: <Widget>[

          GetBuilder<HomeController>(
            builder: (controller){
              return controller.tabsButtonState == 0 
                  ? _contentsView(size)
                  : _myPageView(size);
            },
          ),

          _bottomTabs(size),

        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    Size size = MediaQuery.of(context).size;

    return Platform.isAndroid
        ? MaterialApp(
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: _pageView(size),
            ),
          )
        : CupertinoApp(
            home: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              child: _pageView(size),
            ),
          );
  }
}
