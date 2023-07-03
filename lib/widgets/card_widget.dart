import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/controllers/user_controller.dart';
import 'dart:io';

import 'package:shopping_mall/ui/card_registration.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  _deleteCardView(Size size, List<dynamic> credits, dynamic selectCard) {
    String title = '카드를 제거하시겠습니까?';
    String btnText = '카드 제거하기';

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
                    firebaseController.deleteCard(credits, selectCard);
                    Navigator.pop(context);
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
              firebaseController.deleteCard(credits, selectCard);
              Navigator.pop(context);
            },
            child: Text(btnText),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;
    List<String> data = [];
    List<String> cardNumbers = [];

    return GetBuilder<UserController>(
      builder: (controller) {
        return Container(
          width: size.width,
          height: size.height * 0.3,
          // margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListView.builder(
            itemCount: controller.userInfo!.credits!.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index < controller.userInfo!.credits!.length) {
                for (int i = 0; i < controller.userInfo!.credits!.length; i++) {
                  String temp = controller.userInfo!.credits![index].toString();
                  data = temp.split("&");
                  cardNumbers.add(data[0]);
                }
                return GestureDetector(
                  onLongPress: () {
                    String selectCard = controller.userInfo!.credits![index];
                    _deleteCardView(size, controller.userInfo!.credits!, selectCard);
                  },
                  child: CreditCardWidget(
                    cardType: CardType.mastercard,
                    padding: size.width * 0.02,
                    width: size.width * 0.9,
                    cardNumber: data[0],
                    expiryDate: data[1],
                    cvvCode: data[2],
                    showBackView: false,
                    cardBgColor: Colors.black,
                    labelValidThru: 'VALID\nTHRU',
                    obscureCardNumber: true,
                    obscureInitialCardNumber: false,
                    obscureCardCvv: true,
                    isHolderNameVisible: false,
                    isChipVisible: true,
                    isSwipeGestureEnabled: false,
                    animationDuration: const Duration(milliseconds: 1000),
                    frontCardBorder: Border.all(color: Colors.grey),
                    backCardBorder: Border.all(color: Colors.grey),
                    onCreditCardWidgetChange: (CreditCardBrand) {},
                    cardHolderName: '',
                  ),
                );
              }
              return GestureDetector(
                onTap: () async {
                  Platform.isAndroid
                      ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          CardRegistration(cardNumber: cardNumbers,
                              cards: controller.userInfo!.credits!)))
                      : Navigator.push(context,
                      CupertinoPageRoute(builder: (context) =>
                          CardRegistration(cardNumber: cardNumbers,
                              cards: controller.userInfo!.credits!)));
                },
                child: Container(
                  width: size.width * 0.9,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(left: marginWidth,
                      right: marginWidth,
                      bottom: marginHeight),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add, color: Colors.blue,
                        size: size.width * 0.08,),
                      Text(
                        '카드 추가하기',
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          color: Colors.blue,
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
}
