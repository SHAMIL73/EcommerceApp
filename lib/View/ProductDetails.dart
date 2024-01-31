import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_2/Const/Color.dart';
import 'package:flutter_application_2/Controller/CartProvider.dart';
import 'package:flutter_application_2/Controller/WishProvider.dart';
import 'package:flutter_application_2/Model/ApiController.dart';
import 'package:flutter_application_2/Controller/DarkModeGetx.dart';
import 'package:flutter_application_2/View/Wishlist.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductsDetails extends StatefulWidget {
  final Product product;

  const ProductsDetails({super.key, required this.product});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  @override
  void initState() {
    super.initState();
    Get.put(DarkModeGetx());
    updateThemeColors();
  }

  void updateThemeColors() {
    setState(() {
      getTextColor();
    });
  }

  Color getTextColor() {
    return Get.find<DarkModeGetx>().isDarkMode ? whitecolor : blackcolor;
  }

  Color getTextColor2() {
    return Get.find<DarkModeGetx>().isDarkMode ? blackcolor : whitecolor;
  }

  final CollectionReference Add_Users =
      FirebaseFirestore.instance.collection('Users');
  late final Product product;
  late final CollectionReference cart;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor:
          Get.find<DarkModeGetx>().isDarkMode ? Colors.white : Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: getTextColor2()),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Text(
          product.brand,
          style: TextStyle(
            color: getTextColor2(),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 309,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              autoPlay: true, // Enable auto play
              autoPlayInterval:
                  Duration(seconds: 2), // Set the interval to 2 seconds
            ),
            items: product.images.map<Widget>((imageUrl) {
              return SizedBox(
                width: 300,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              );
            }).toList(),
          ),
          Text(
            product.title,
            style: TextStyle(color: getTextColor2(), fontSize: 20),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: RichText(
              text: TextSpan(
                text: 'about : ',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: product.description,
                    style: TextStyle(
                      color: getTextColor2(),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Row(
                    children: [
                      Text(
                        "FREE DELIVERY",
                        style: TextStyle(
                          color: getTextColor2(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.card_travel,
                        color: getTextColor2(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Container(
                          width:
                              35.0, // Set the width and height according to your requirements
                          height: 35.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getTextColor2(),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<WishProvider>(context, listen: false)
                                  .wishToFirestore(product);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: getTextColor(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
            onTap: () {
              Provider.of<CartProvider>(context, listen: false)
                  .cartToFirestore(product);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const CartPage(),
              //   ),
              // );
            },
            child: Container(
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                color: getTextColor2(),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: getTextColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              

              
            },
            child: Container(
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                color: getTextColor2(),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  'BUY NOW',
                  style: TextStyle(
                    color: getTextColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}