import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/widgets/text_widget.dart';

class CardRegistration extends StatefulWidget {
  final List<dynamic>? cardNumber;
  final List<dynamic>? cards;

  const CardRegistration({Key? key, this.cardNumber, this.cards}) : super(key: key);

  @override
  State<CardRegistration> createState() => _CardRegistrationState();
}

class _CardRegistrationState extends State<CardRegistration> {

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _validController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  String number = "";
  String valid = "";
  String cvc = "";

  String alertString = "";

  Widget _cardView(Size size){

    return Container(
      width: size.width,
      height: size.height * 0.3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: CreditCardWidget(
        cardType: CardType.mastercard,
        padding: size.width * 0.02,
        width: size.width * 0.9,
        cardNumber: _numberController.text,
        expiryDate: _validController.text.isNotEmpty ? _validController.text.replaceRange(2, 2, '/') : _validController.text,
        cvvCode: _cvcController.text,
        showBackView: false,
        cardBgColor: Colors.black,
        labelValidThru: 'VALID\nTHRU',
        obscureCardNumber: true,
        obscureInitialCardNumber: false,
        obscureCardCvv: true,
        isHolderNameVisible: true,
        isChipVisible: true,
        isSwipeGestureEnabled: false,
        animationDuration: Duration(milliseconds: 1000),
        frontCardBorder: Border.all(color: Colors.grey),
        backCardBorder: Border.all(color: Colors.grey),
        onCreditCardWidgetChange: (CreditCardBrand ) {  },
        cardHolderName: '',
      ),
    );
  }

  Widget _backPageButton(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.05,
      margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: size.width * 0.08,
        ),
      ),
    );
  }

  Widget _inputForm(Size size, TextEditingController controller, String hint){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;
    int maxLength = 0;

    if(controller == _numberController){
      maxLength = 16;
    }
    else if(controller == _validController){
      maxLength = 4;
    }
    else{
      maxLength = 3;
    }

    return Container(
      width: size.width,
      height: size.height * 0.08,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: marginHeight),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Platform.isAndroid
          ? SizedBox(
        height: size.height * 0.1,
        child: TextField(
          controller: controller,
          obscureText: true,
          maxLength: maxLength,
          decoration: InputDecoration(
            filled: true,
            hintText: hint,
          ),
        ),
      )
          : SizedBox(
        height: size.height * 0.08,
        child: CupertinoTextField(
          controller: controller,
          obscureText: true,
          placeholder: hint,
          maxLength: maxLength,
        ),
      ),
    );
  }

  bool _checkValidForm(){
    if(_numberController.text.isEmpty){
      alertString = "카드번호를 입력해 주세요.";
      return false;
    }
    else{
      if(_numberController.text.length < 16){
        alertString = "카드번호를 다시 입력해 주세요.";
        return false;
      }
      else {
        for(int i=0; i<widget.cardNumber!.length; i++){
          if(_numberController.text == widget.cardNumber![i]){
            alertString == "이미 등록된 카드입니다.";
            return false;
          }
        }
      }
    }

    if(_validController.text.isEmpty){
      alertString = "유효기간을 입력해 주세요.";
      return false;
    }
    else{
      if(_validController.text.length < 4){
        alertString = "유효기간을 다시 입력해 주세요.";
        return false;
      }
    }

    if(_cvcController.text.isEmpty){
      alertString = "cvc번호를 입력해 주세요.";
      return false;
    }
    else{
      if(_cvcController.text.length < 3){
        alertString = "cvc번호를 다시 입력해 주세요.";
        return false;
      }
    }
    return true;
  }

  _alertView(Size size){
    return Platform.isAndroid
        ? showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: size.width * 0.5,
          height: size.height * 0.2,
          alignment: Alignment.center,
          child: Text(
            alertString,
            style: TextStyle(
              fontSize: size.width * 0.05,
            ),
          ),
        ),
        actions: [
          Container(
              width: size.width * 0.5,
              height: size.height * 0.2,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '확인',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                  ),
                ),
              )
          ),
        ],
      );
    })
        : showCupertinoDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        content: Container(
          width: size.width * 0.5,
          height: size.height * 0.1,
          alignment: Alignment.center,
          child: Text(
            alertString,
            style: TextStyle(
              fontSize: size.width * 0.05,
            ),
          ),
        ),
        actions: [
          Container(
              width: size.width * 0.5,
              height: size.height * 0.1,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '확인',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                  ),
                ),
              )
          ),
        ],
      );
    });
  }

  Widget _okButton(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return GestureDetector(
      onTap: () async {
        bool validRes = _checkValidForm();
        if(validRes){
          String date = _validController.text.replaceRange(2, 2, '/');
          await firebaseController.insertCard(_numberController.text, date, _cvcController.text, widget.cards!);
          Navigator.pop(context);
        }
        else{
          _alertView(size);
        }
      },
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: marginHeight, right: marginWidth, left: marginWidth),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16.0)
        ),
        child: Text(
          '카드 등록',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.08,
          ),
        ),
      ),
    );
  }

  Widget _pageView(Size size){

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[

              _backPageButton(size),

              _cardView(size),

              TextWidget(text: "카드번호", alignment: Alignment.centerLeft, textSize: size.width * 0.06,),

              _inputForm(size, _numberController, '카드번호'),

              TextWidget(text: "유효기간", alignment: Alignment.centerLeft, textSize: size.width * 0.06,),

              _inputForm(size, _validController, '유효기간'),

              TextWidget(text: "CVC", alignment: Alignment.centerLeft, textSize: size.width * 0.06,),

              _inputForm(size, _cvcController, 'cvc'),

              _okButton(size),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _numberController.dispose();
    _validController.dispose();
    _cvcController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Platform.isAndroid
        ? MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF202020),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _pageView(size),
        ),
      ),
    )
        : CupertinoApp(
      home: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF202020),
        resizeToAvoidBottomInset: false,
        child: SafeArea(
          child: _pageView(size),
        ),
      ),
    );
  }
}
