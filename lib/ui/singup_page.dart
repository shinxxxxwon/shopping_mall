import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/controllers/firebase_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userPhone = TextEditingController();
  final TextEditingController _userAddress = TextEditingController();

  Widget _title(Size size){
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.07,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: size.height * 0.01, left: marginWidth, right: marginWidth, bottom: size.height * 0.01),
      child: Text(
        '회원가입',
        style: TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _idForm(Size size){
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: size.height * 0.01),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Platform.isAndroid
          ? TextField(
        controller: _userId,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '아이디',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      )
          : SizedBox(
        height: size.height * 0.1,
        child: CupertinoTextField(
          controller: _userId,
          placeholder: "아이디",
          placeholderStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _passwordForm(Size size){
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: size.height * 0.01),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Platform.isAndroid
          ? TextField(
        controller: _userPassword,
        obscureText: true,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '비밀번호',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      )
          : SizedBox(
        height: size.height * 0.1,
        child: CupertinoTextField(
          controller: _userPassword,
          obscureText: true,
          placeholder: '비밀번호',
          placeholderStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _nameForm(Size size){
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: size.height * 0.01),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Platform.isAndroid
          ? TextField(
        controller: _userName,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '이름',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      )
          : SizedBox(
        height: size.height * 0.1,
        child: CupertinoTextField(
          controller: _userName,
          placeholder: "이름",
          placeholderStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _phoneForm(Size size){
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: size.height * 0.01),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Platform.isAndroid
          ? TextField(
        controller: _userPhone,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          NumberFormatter(),
          LengthLimitingTextInputFormatter(13)
        ],
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '전화번호',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      )
          : SizedBox(
        height: size.height * 0.1,
        child: CupertinoTextField(
          controller: _userPhone,
          keyboardType: TextInputType.number,
          placeholder: "전화번호",
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NumberFormatter(),
            LengthLimitingTextInputFormatter(13)
          ],
          placeholderStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _addressForm(Size size){
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: size.height * 0.01),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Platform.isAndroid
          ? TextField(
        controller: _userAddress,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '주소',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      )
          : SizedBox(
        height: size.height * 0.1,
        child: CupertinoTextField(
          controller: _userAddress,
          placeholder: "주소",
          placeholderStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(Size size){
    return Container(
      width: size.width,
      height: size.height * 0.05,
      margin: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          '이미 회원이신가요? 로그인',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: size.width * 0.03,
          ),
        ),
      ),
    );
  }

  bool _checkCondition(){
    if(_userId.text.length < 4){
      return false;

    }
    else if(_userPassword.text.length < 8){
      return false;
    }
    else if(_userName.text.length < 1){
      return false;
    }
    else if(_userPhone.text.length != 13){
      return false;
    }
    else if(_userAddress.text.isEmpty){
      return false;
    }
    return true;
  }

  Widget _alertDuplication(Size size){
    String text = "";

    if(_userId.text.length < 4){
      text = "아이디는 4글자 이상이어야합니다.";
    }
    else if(_userPassword.text.length < 8){
      text = "비밀번호는 8글자 이상이어야합니다.";
    }
    else if(_userName.text.length < 1){
      text = "이름을 입력해주세요.";
    }
    else if(_userPhone.text.length != 13){
      text = "휴대폰 번호를 입력해주세요.";
    }
    else if(_userAddress.text.isEmpty){
      text = "주소를 입력해주세요.";
    }

    return Container(
      width: size.width * 0.4,
      height: size.height * 0.3,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width * 0.05,
        ),
      ),
    );
  }

  Widget _okButton(Size size){
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.1,
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          '확인',
          style: TextStyle(
            color: Colors.black,
            fontSize: size.width * 0.05,
          ),
        ),
      ),
    );
  }

  Widget _signupButton(Size size){

    final marginWidth = size.width * 0.05;

    return GestureDetector(
      onTap: () async {
        final check = await firebaseController.keyCheck(_userId.value.text);
        if(!_checkCondition()){
          Platform.isAndroid
              ? showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      content: _alertDuplication(size),
                      actions: [
                        _okButton(size),
                      ],
                    );
                  })
              : showCupertinoDialog(
                  context: context,
                  builder: (context){
                    return CupertinoAlertDialog(
                      content: _alertDuplication(size),
                      actions: [
                        _okButton(size),
                      ],
                    );
                  }
          );
        }
        else if(check){
          Platform.isAndroid
              ? showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Container(
                    width: size.width * 0.4,
                    height: size.height * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      '중복된 아이디 입니다.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                  ),
                  actions: [
                    _okButton(size),
                  ],
                );
              })
              : showCupertinoDialog(
              context: context,
              builder: (context){
                return CupertinoAlertDialog(
                  content: Container(
                    width: size.width * 0.4,
                    height: size.height * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      '중복된 아이디 입니다.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                  ),
                  actions: [
                    _okButton(size),
                  ],
                );
              }
          );
        }
        else{
          await firebaseController.insertUser(
              _userId.text,
              _userPassword.text,
              _userName.text,
              _userPhone.text,
              _userAddress.text
          );

          Get.back();
        }
      },
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        margin: EdgeInsets.only(left: marginWidth, right: marginWidth),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          '회원가입',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.05,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _pageView(Size size){

    final marginHeight = size.height * 0.1;
    final marginWidth = size.width * 0.05;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1627292441194-0280c19e74e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
                fit: BoxFit.fill
            ),
          ),
          child: Container(
            width: size.width,
            height: size.height,
            margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: <Widget>[

                _title(size),

                _idForm(size),

                _passwordForm(size),

                _nameForm(size),

                _phoneForm(size),

                _addressForm(size),

                _signupButton(size),

                _loginButton(size)

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    Size _size = MediaQuery.of(context).size;

    return Platform.isAndroid
        ? MaterialApp(
      home: Scaffold(
        body: _pageView(_size),
      ),
    )
        : CupertinoApp(
      home: CupertinoPageScaffold(
        child: _pageView(_size),
      ),
    );
  }
}


class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}