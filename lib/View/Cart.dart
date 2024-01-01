import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart(
      {Key? key, required this.images, required this.title, required this.price})
      : super(key: key);

  final String images;
  final String title;
  final int price;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(stream:cart.snapshots(), 
                         builder: (context, AsyncSnapshot snapshot) {
if (snapshot.hasData){
  return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot cartSnap = snapshot.data.docs[index];
          return Column(
            children: [
              Text(cartSnap['title']),
            ],
          );
        }
      );
}return Container(color: Colors.black,
height: 100,
width: 200,);                         },
      
      )
    );
  }
}
