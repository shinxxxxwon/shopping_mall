import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/controllers/firebase_controller.dart';
import 'package:shopping_mall/widgets/login_widget.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String imageUrl = "";
  bool _isTouch = false;

  @override
  void initState() {
    // TODO: implement initState
    firebaseController.init();
    super.initState();

  }


  getImageUrl() async{
    imageUrl = await firebaseController.downloadImage('firstPageModel');
  }

  Widget _pageView() {
    return GestureDetector(
      onTap: (){
        if(!_isTouch) {
          setState(() {
            _isTouch = true;
          });
        }
      },
      child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1627292441194-0280c19e74e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
                fit: BoxFit.fill
            ),
          ),
          child: _isTouch
              ? const LoginWidget()
              : const Text(
            '화면을 터치해 주세요.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Platform.isAndroid
        ? GetMaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        body:  _pageView(),
      ),
    )
        : GetCupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoPageScaffold(
        resizeToAvoidBottomInset : false,
        child: _pageView(),
      ),
    );
  }
}



