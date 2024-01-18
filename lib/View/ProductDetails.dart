import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_2/Const/Color.dart';
import 'package:flutter_application_2/Controller/CartProvider.dart';
import 'package:flutter_application_2/Model/ApiController.dart';
import 'package:flutter_application_2/Controller/DarkModeGetx.dart';
import 'package:flutter_application_2/View/Cart.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductsDetails extends StatefulWidget {
  final Product product;

  const ProductsDetails({super.key, required this.product});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  late Color textColor;
  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    Get.put(DarkModeGetx());
    updateThemeColors();
  }

  void updateThemeColors() {
    setState(() {
      textColor = getTextColor();
      backgroundColor = getBackgroundColor();
    });
  }

  Color getTextColor() {
    return Get.find<DarkModeGetx>().isDarkMode ? whitecolor : blackcolor;
  }

  Color getBackgroundColor() {
    return Get.find<DarkModeGetx>().isDarkMode ? blackcolor : whitecolor;
  }

  Color getTextColor2() {
    return Get.find<DarkModeGetx>().isDarkMode ? blackcolor : whitecolor;
  }

  Color getBackgroundColor2() {
    return Get.find<DarkModeGetx>().isDarkMode ? whitecolor : blackcolor;
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
          Get.find<DarkModeGetx>().isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: getTextColor()),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Text(
          product.brand,
          style: TextStyle(
            color: getTextColor(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                Get.find<DarkModeGetx>().isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
                size: 30,
                color: textColor,
              ),
              onPressed: () {
                Get.find<DarkModeGetx>().toggleTheme();
                updateThemeColors();
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 309,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
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
            style: TextStyle(color: getTextColor(), fontSize: 20),
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
                      color: getTextColor(),
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
                          color: getTextColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.card_travel,
                        color: getTextColor(),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                color: getTextColor(),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: getTextColor2(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
              color: getTextColor(),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                'ADD TO WISHLIST',
                style: TextStyle(
                  color: getTextColor2(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}