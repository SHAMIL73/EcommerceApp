import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart(
      {Key? key,})
      : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CollectionReference cart =
      FirebaseFirestore.instance.collection('cart');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: cart.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            snapshot.hasData; {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot cartSnap = snapshot.data.docs[index];
                    return Column(
                      children: [
                        const SizedBox(height: 20,),
                        Container(width: double.infinity,
                        height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),child: Column(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 40,
                          child: Image.network(
                              cartSnap['thumbnail'],
                          ),
                        ),
                      ],
                    ),
                        ),
                      ],
                    );
                  }
                  );
            }
          },
        ));
  }
}