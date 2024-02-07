import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WishProvider extends ChangeNotifier {
  final user = FirebaseFirestore.instance
      .collection('Wish')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  Future<List<Map<String, dynamic>>> getWishList() async {
    List<Map<String, dynamic>> cartlist2 = [];
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('Wish')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userData.exists) {
      Map<String, dynamic>? userDataMap =
          userData.data() as Map<String, dynamic>?;

      List<dynamic>? cartData =
          List.from(userDataMap?['cartlist2'] as List<dynamic>);

      cartlist2 = cartData
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

    return cartlist2;
  }

  Future<void> wishToFirestore(product) async {
    final total = FirebaseFirestore.instance
        .collection('Wish')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final users = await total.get();

    if (!users.exists) {
      total.set({'cartlist2': []});
    }
    final data = {
      'cartlist2': FieldValue.arrayUnion([
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
        .collection('Wish')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist2 =
          List.from(userDataMap?['cartlist2'] as List<dynamic>);
      bool productAlreadyInCart = cartlist2
          .any((item) => item['id'] == product.id);
      if (!productAlreadyInCart) {
        user.update(data);
        showToast('Product added');
      } else {
        showToast('Product is already in the Wishlist');
      }
    } else {
      user.set({'cartlist2': []});
    }

    notifyListeners();
  }
  /////////////////////
  Future<void> removeFromWish(String productId) async {
  final userDoc = FirebaseFirestore.instance
      .collection('Wish')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  DocumentSnapshot userdata = await userDoc.get();
  if (userdata.exists) {
    Map<String, dynamic>? userDataMap =
        userdata.data() as Map<String, dynamic>?;

    List<dynamic>? cartlist2 =
        List.from(userDataMap?['cartlist2'] as List<dynamic>);

    cartlist2.removeWhere((item) => item['id'].toString() == productId);

    await userDoc.update({
      'cartlist2': cartlist2,
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