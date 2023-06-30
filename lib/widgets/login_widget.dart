import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/controllers/user_controller.dart';
import 'package:shopping_mall/ui/main_page.dart';
import 'package:shopping_mall/ui/singup_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String errorMsg = "";

  Widget _loginIcon(Size size){
    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
      padding: EdgeInsets.all(size.width * 0.05),
      child: Text(
        'SJW SHOP',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size.width * 0.08,
          color: Colors.white
        ),
      ),
    );
  }

  Widget _showText(Size size, String text){
    final paddingWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.05,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.05,
        ),
      ),
    );
  }

  Widget _inputLoginInfo(Size size, int type, String? hint){

    final paddingWidth = size.width * 0.05;
    final paddingHeight = size.height * 0.01;
    String hintText = hint ?? '';

    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: paddingHeight, left: paddingWidth, right: paddingWidth),
      child: Platform.isAndroid
          ? TextField(
        controller: type == 0 ? _idController : _pwController,
        obscureText: type == 0 ? false : true,
        // focusNode: _focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      )
          : SizedBox(
        height: size.height * 0.1,
        child: CupertinoTextField(
          controller: type == 0 ? _idController : _pwController,
          obscureText: type == 0 ? false : true,
          // focusNode: _focusNode,
          placeholder: hintText,
          placeholderStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(Size size){
    final marginWidth = size.width * 0.05;
    final marginHeight = size.height * 0.02;

    return GestureDetector(
      onTap: () async {

        var userData = await firebaseController.getUserData(_idController.text, _pwController.text);
        if(!userData){
          setState(() {
            errorMsg = "아이디 또는 비밀번호를 잘못입력하셨습니다.";
          });
        }
        else{
          // Get.find<UserController>().getUserInfo(userData);
          print('로그인 성공');

          Get.to(const MainPage());
        }
      },
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        alignment: Alignment.center,
        // padding: EdgeInsets.only(top: paddingHeight, left: paddingWidth, right: paddingWidth),
        margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.red,
        ),
        child: Text(
          '로그인',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.05,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }

  Widget _singupButton(Size size){
    final marginWidth = size.width * 0.05;

    return TextButton(
      onPressed: () => Get.to(const SignupPage()),
      child: Text(
        '회원이 아니신가요?',
        style: TextStyle(
          fontSize: size.width * 0.03,
        ),
      ),
    );
  }

  Widget _loginForm(Size size){
    return Column(
      children: <Widget>[
        
        _loginIcon(size),

        _showText(size, 'ID'),

        _inputLoginInfo(size, 0, 'ID'),

        _showText(size, "PW"),

        _inputLoginInfo(size, 1, 'Password'),

        Text(
          errorMsg,
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.03,
          ),
        ),

        _loginButton(size),

        _singupButton(size),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    final marginTop = size.height * 0.3;
    final marginWidth = size.width * 0.05;
    final marginBottom = size.height * 0.07;

    return GestureDetector(
      onTap: (){
        _focusNode.unfocus();
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              top: marginTop,
              left: marginWidth,
              right: marginWidth,
              bottom: marginBottom
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: _loginForm(size)
      ),
    );
  }
}
