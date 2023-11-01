import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/firebase_controller.dart';
import 'package:shopping_mall/widgets/back_page_widget.dart';
import 'package:shopping_mall/widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProductRegistrationPage extends StatefulWidget {
  final String? userId;

  const ProductRegistrationPage({Key? key, this.userId}) : super(key: key);

  @override
  State<ProductRegistrationPage> createState() => _ProductRegistrationPageState();
}

class _ProductRegistrationPageState extends State<ProductRegistrationPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  int _category1 = 0;
  int _category2 = 0;

  List<Text> aosBrands = [
    const Text('GUCCI'),
    const Text('BERBURY'),
    const Text('Louis Vuitton'),
    const Text('CHANNEL'),
    const Text('PRADA')
  ];
  List<Text> aosCategorys = [
    const Text('Cloths'),
    const Text('Bags'),
    const Text('Shoes')
  ];

  List<String> iosBrands = [
    'GUCCI',
    'BERBURY',
    'Louis Vuitton',
    'CHANNEL',
    'PRADA'
  ];
  List<String> iosCategorys = [
    'Cloths',
    'Bags',
    'Shoes'
  ];

  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _pickedImages = [];

  String _selectBrand = "";
  String _category = "";


  Widget _inputForm(Size size, TextEditingController controller, String hint, int type){
    final marginHeight = size.height * 0.01;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: type == 0 ? size.height * 0.07 : size.height * 0.2,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: marginWidth, right: marginWidth, bottom: marginHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Platform.isAndroid
          ? TextField(
        controller: controller,
        maxLines: type == 0 ? 1 : 4,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hint,
          filled: true,
        ),
      )
          : SizedBox(
        height: type == 0 ? size.height * 0.07 : size.height * 0.2,
        child: CupertinoTextField(
          controller: controller,
          placeholder: hint,
        ),
      ),
    );
  }

  void _showPicker(Size size, int type){
    Platform.isAndroid ?
    BottomPicker(
      height: size.height * 0.3,
      items: type == 0 ? aosBrands : aosCategorys,
      title: '브랜드를 선택해 주세요.',
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
      backgroundColor: Colors.white,
      onChange: (index){
        setState(() {
          if(type == 0) {
            _category1 = index;
          }
          else{
            _category2 = index;
          }
        });
      },
      onClose: (){
        if(type == 0) {
          _selectBrand = aosBrands[_category1].data!;
        }
        else {
          _category = aosCategorys[_category2].data!;
        }
      },
      dismissable: true,
      onSubmit: (index) {
        print(index);
      },
      buttonAlignement: MainAxisAlignment.center,
      displayButtonIcon: false,
      displaySubmitButton: false,
    ).show(context)

    : showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: size.height * 0.3,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 30,
            // This sets the initial item.
            scrollController: FixedExtentScrollController(
              initialItem: 0,
            ),
            onSelectedItemChanged: (int selectedItem) {
              setState(() {
                if(type == 0){
                  _category1 = selectedItem;
                  _selectBrand = iosBrands[selectedItem];
                }
                else{
                  _category2 = selectedItem;
                  _category = iosCategorys[selectedItem];
                }
              });
            },
            children:
            List<Widget>.generate(type == 0 ? iosBrands.length : iosCategorys.length, (int index) {
              return Center(child: Text(type == 0 ? iosBrands[index] : iosCategorys[index]));
            }),
          ),
        ),
      ),
    );
  }

  Widget _categoryView(Size size, String text, int type){
    return Expanded(
      child: Row(
        children: <Widget>[

          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
            ),
          ),

          SizedBox(width: size.width * 0.02),

          GestureDetector(
            onTap: (){
              _showPicker(size, type);
            },
            child: Container(
              width: size.width * 0.2,
              height: size.height * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(),
              ),
              child: type == 0
                  ? _selectBrand.isEmpty ? aosBrands[0] : Text(_selectBrand)
                  : _category.isEmpty ? aosCategorys[0] : Text(_category)
            ),
          ),

        ],
      ),
    );
  }

  Widget _imageUpload(Size size){
    final marginHeight = size.height * 0.01;
    final marginWidth = size.width * 0.05;

    return Container(
      width: size.width,
      height: size.height * 0.3,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(),
        color: Colors.white,
      ),
      child: _pickedImages.isEmpty
          ? GestureDetector(
        onTap: () => getImage(ImageSource.gallery),
        child: Icon(Icons.add, color: Colors.blue, size: size.width * 0.1),
      )
          : Image.file(File(_pickedImages[0]!.path)),
    );
  }

  Widget _alertDuplication(Size size){
    String text = "";

    if(_titleController.text.isEmpty){
      text = "제목을 입력해주세요.";
    }
    else if(_infoController.text.isEmpty){
      text = "정보를 입력해주세요.";
    }
    else if(_priceController.text.isEmpty){
      text = "가격을 입력해주세요.";
    }
    else if(_pickedImages.isEmpty){
      text = "사진을 등록해주세요.";
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
    final marginHeight = size.height * 0.01;
    final marginWidth = size.width * 0.05;

    return GestureDetector(
      onTap: () async{
        if(!_checkCondition()){
          Platform.isAndroid
              ? showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: _alertDuplication(size),
                  actions: [
                    Container(
                      width: size.width * 0.4,
                      height: size.height * 0.1,
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })
              : showCupertinoDialog(
              context: context,
              builder: (context){
                return CupertinoAlertDialog(
                  content: _alertDuplication(size),
                  actions: [
                    Container(
                      width: size.width * 0.4,
                      height: size.height * 0.1,
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
          );
        }
        else{
          await firebaseController.insertProduct(
              widget.userId!,
              _titleController.text,
              _infoController.text,
              _category1,
              _category2,
              int.parse(_priceController.text),
              _pickedImages[0]!,
          );

          Get.back();
        }
      },
      child: Container(
        width: size.width,
        height: size.height * 0.07,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16.0)
        ),
        child: Text(
          '상품 등록',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: size.width * 0.06,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _pageView(Size size){
    final marginHeight = size.height * 0.02;
    final marginWidth = size.width * 0.05;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[

            const BackPageWidget(text: '상품등록', color: Colors.black),

            TextWidget(text: '제목', alignment: Alignment.centerLeft, color: Colors.black, textSize: size.width * 0.04),

            _inputForm(size, _titleController, '제목을 입력해주세요.', 0),

            Container(
              width: size.width,
              height: size.height * 0.1,
              margin: EdgeInsets.only(top: marginHeight, left: marginWidth, right: marginWidth, bottom: marginHeight),
              child: Row(
                children: [
                  _categoryView(size, '브랜드', 0),

                  _categoryView(size, '카테고리', 1),
                ],
              ),
            ),

            TextWidget(text: '설명', alignment: Alignment.centerLeft, color: Colors.black, textSize: size.width * 0.04),

            _inputForm(size, _infoController, '설명을 입력해주세요.', 1),

            TextWidget(text: '가격', alignment: Alignment.centerLeft, color: Colors.black, textSize: size.width * 0.04),

            _inputForm(size, _priceController, '가격을 입력해주세요.', 0),

            _imageUpload(size),

            _okButton(size),

          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Platform.isAndroid
        ? MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _pageView(size),
        ),
      ),
    )
        : CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: SafeArea(
          child: _pageView(size),
        ),
      ),
    );
  }

  bool _checkCondition(){
    if(_titleController.text.isEmpty){
      return false;
    }
    else if(_infoController.text.isEmpty){
      return false;
    }
    else if(_priceController.text.isEmpty){
      return false;
    }
    else if(_pickedImages.isEmpty){
      return false;
    }
    return true;
  }

  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _pickedImages.add(image);
      });
    }
  }



}
