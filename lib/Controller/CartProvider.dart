import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider extends ChangeNotifier {
  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  Future<List<Map<String, dynamic>>> getCartList() async {
    List<Map<String, dynamic>> cartList = [];
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userData.exists) {
      Map<String, dynamic>? userDataMap =
          userData.data() as Map<String, dynamic>?;

      List<dynamic>? cartData =
          List.from(userDataMap?['cartlist'] as List<dynamic>);

      cartList = cartData
          .map((item) => {
                'thumbnail': item['thumbnail'],
                'images': item['images'],
                'price': item['price'],
                'description': item['description'],
                'discountPercentage': item['discountPercentage'],
                'rating': item['rating'],
                'title': item['title'],
                'stock': item['stock'],
                'id': item['id'],
              })
          .toList();
    }

    return cartList;
  }

  Future<void> cartToFirestore(product) async {
    final total = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final users = await total.get();

    if (!users.exists) {
      total.set({'cartlist': []});
    }
    final data = {
      'cartlist': FieldValue.arrayUnion([
        {
          'thumbnail': product.thumbnail,
          'images': product.images,
          'price': product.price,
          'description': product.description,
          'discountPercentage': product.discountPercentage,
          'rating': product.rating,
          'title': product.title,
          'stock': product.stock,
          'id': product.id,
        }
      ]),
    };

    DocumentSnapshot userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist =
          List.from(userDataMap?['cartlist'] as List<dynamic>);
      bool productAlreadyInCart = cartlist
          .any((item) => item['id'] == product.id);
      if (!productAlreadyInCart) {
        user.update(data);
        showToast('Product added');
      } else {
        showToast('Product is already in the Cart');
      }
    } else {
      user.set({'cartlist': []});
    }

    notifyListeners();
  }
  /////////////////////
  Future<void> removeFromCart(String productId) async {
  final userDoc = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  DocumentSnapshot userdata = await userDoc.get();
  if (userdata.exists) {
    Map<String, dynamic>? userDataMap =
        userdata.data() as Map<String, dynamic>?;

    List<dynamic>? cartlist =
        List.from(userDataMap?['cartlist'] as List<dynamic>);

    cartlist.removeWhere((item) => item['id'].toString() == productId);

    await userDoc.update({
      'cartlist': cartlist,
    });

    showToast('Product removed from the Cart');
  }

  notifyListeners();
}

  ////////////////////

  void showToast(String message) {
    print('Toast: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}