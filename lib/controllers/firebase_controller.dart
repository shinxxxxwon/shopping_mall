
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/product_controller.dart';
import 'package:shopping_mall/controllers/user_controller.dart';
import 'package:shopping_mall/models/product/product_model.dart';
import 'package:shopping_mall/models/user/user_model.dart';

class FirebaseController{
  UserModel? userData;
  String gsUrl = 'gs://sjw-shoppingmall.appspot.com';

  FirebaseStorage? _storage;
  Reference? _storageRef;
  FirebaseFirestore? _firestore;

  init() async {
    await Firebase.initializeApp();
    _storage = FirebaseStorage.instance;
    _storageRef = _storage!.ref();
    _firestore = FirebaseFirestore.instance;

  }

  Future<String> downloadImage(String? image) async {
    if(image == null){
      return 'null';
    }
    try{
      String imageUrl = await _storageRef!.child('images').child('$image.jpg').getDownloadURL();
      print('image Url : $imageUrl');
      return imageUrl;
    }catch(e){
      print('downloadImage error : ${e.toString()}');
    }
    return 'null';
  }

  Future<String> uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = _storageRef!.child('images/$fileName');

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  insertProduct(String id, String title, String info, int category1, int category2, String price, String images) async{

    print('id : $id');
    print('title : $title');
    print('info : $info');
    print('category1 : $category1');
    print('category2 : $category2');
    print('price : $price');
    print('images : ${images}');

    try {
      final productRef = await FirebaseFirestore.instance.
      collection('shop/sOM21LLf2mJY8GyjLjoo/product').doc();

      productRef.set({
        'id': id,
        'title': title,
        'info': info,
        'category1': category1,
        'category2': category2,
        'price': price,
        'images': images
      });

      final product = ProductModel(id: id, title: title, info: info, category1: category1, category2: category2, price: price, images: images);
      Get.find<ProductController>().addProduct(product);


    }catch(e){
      print('insert Card Error : ${e.toString()}');
    }



  }

  getMyProductData(String id) async{
    if(Get.find<ProductController>().products.isNotEmpty){
      Get.find<ProductController>().products.clear();
    }

    try{
      List<ProductModel> products = [];
      final productRef = await _firestore!.collection('shop/sOM21LLf2mJY8GyjLjoo/product').get();

      productRef.docs.forEach((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        if(data['id'].toString() == id){
          final product = ProductModel(id: id, title: data['title'], info: data['info'], category1: data['category1'], category2: data['category2'], price: data['price'], images: data['images']);
          products.add(product);
        }
      });
      print('products : $products');
      Get.find<ProductController>().getProducts(products);
    }catch(e){
      print('getMyProductData error : ${e.toString()}');
    }
  }


  getUserData(String id, String password) async{
    final userInfo = await _firestore!.collection('shop/sOM21LLf2mJY8GyjLjoo/user').doc(id).get();

    if(userInfo.exists) {
      Map<String, dynamic>? data = userInfo.data();
      if(password == data!['password']) {
        final controller = Get.put(UserController());
        userData = UserModel(id: data['id'], password: data['password'], name: data['name'], phone: data['phone'], address: data['address'], credits: data['credits']);
        Get.find<UserController>().getUserInfo(userData!);
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
  }

  keyCheck(String id) async {
    final snapshot = await FirebaseFirestore.instance.
    collection('shop/sOM21LLf2mJY8GyjLjoo/user').doc(id).get();

    print(snapshot.exists);
    return snapshot.exists;
  }

  insertCard(String number, String valid, String cvc, List<dynamic> credits) async{
    String temp = "";
    temp = '$number&$valid&$cvc';

    List<dynamic> data = [];
    data = credits.toList();
    data.add(temp);
    print('data List : $data');

    try {
      await FirebaseFirestore.instance.
      collection('shop/sOM21LLf2mJY8GyjLjoo/user').doc(userData!.id).
      update({'credits':data});

      userData = UserModel(id: userData!.id, password: userData!.password, name: userData!.name, phone: userData!.phone, address: userData!.address, credits: data);
      Get.find<UserController>().getUserInfo(userData!);
      print('userData card : $userData');
    }catch(e){
      print('insert Card Error : ${e.toString()}');
    }
  }

  deleteCard(List<dynamic> credits, dynamic selectCard) async{
    List<dynamic> data = credits.toList();

    for(int i=0; i<credits.length; i++){
      if(credits[i].toString() == selectCard.toString()){
        data.removeAt(i);
      }
    }

    try {
      await FirebaseFirestore.instance.
      collection('shop/sOM21LLf2mJY8GyjLjoo/user').doc(userData!.id).
      update({'credits':data});

      userData = UserModel(id: userData!.id, password: userData!.password, name: userData!.name, phone: userData!.phone, address: userData!.address, credits: data);
      Get.find<UserController>().getUserInfo(userData!);
      print('userData card : $userData');
    }catch(e){
      print('insert Card Error : ${e.toString()}');
    }
  }

  insertUser(String id, String password, String name, String phone, String address) async {
    try{
      await FirebaseFirestore.instance.
      collection('shop/sOM21LLf2mJY8GyjLjoo/user').doc(id).
      set(
          {
            'id':id,
            'password':password,
            'name':name,
            'phone':phone,
            'address':address,
            'credits':[],
          }
      );
    }catch(e){
      print('inset User Error : ${e.toString()}');
    }

  }
}

FirebaseController firebaseController = FirebaseController();