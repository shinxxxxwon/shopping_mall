
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shopping_mall/controllers/user_controller.dart';
import 'package:shopping_mall/models/user_model.dart';

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



  void insertProduct(String id, String name, String info, String imageUrl) {
    _firestore!.collection('product').doc(id).set({
      'id': id,
      'name': name,
      'info': info,
      'image': imageUrl,
    });
  }

  getUserData(String id, String password) async{
    final userInfo = await _firestore!.collection('shop/sOM21LLf2mJY8GyjLjoo/user').doc(id).get();

    if(userInfo.exists) {
      Map<String, dynamic>? data = userInfo.data();
      if(password == data!['password']) {
        final controller = Get.put(UserController());
        userData = UserModel(id: data['id'], password: data['password'], name: data['name'], phone: data['phone'], address: data['address']);
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

  insertUser(String id, String password, String name, String phone, String address) async {
    print('insert');
    await FirebaseFirestore.instance.
    collection('shop/sOM21LLf2mJY8GyjLjoo/user').doc(id).
    set(
      {
        'id':id,
        'password':password,
        'name':name,
        'phone':phone,
        'address':address
      }
    );
    print('insert end');
  }
}

FirebaseController firebaseController = FirebaseController();