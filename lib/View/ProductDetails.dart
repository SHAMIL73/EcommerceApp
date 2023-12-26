import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_2/View/Cart.dart';
import 'package:flutter_application_2/View%20Model/ProviderDemo.dart';
import 'package:provider/provider.dart';

class ProductsDetails extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductsDetails({super.key, required this.product});
  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  Color _getTextColor(BuildContext context) {
    bool isDarkMode = Provider.of<ProviderClass>(context).isDarkMode;
    return isDarkMode ? Colors.white : Colors.black;
  }

  Color _getTextColor2(BuildContext context) {
    bool isDarkMode = Provider.of<ProviderClass>(context).isDarkMode;
    return isDarkMode ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: Provider.of<ProviderClass>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: _getTextColor(context)),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Text(
          product['brand'],
          style: TextStyle(
            color: _getTextColor(context),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Consumer<ProviderClass>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    size: 30,
                    color: _getTextColor(context),
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                );
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
            items: product["images"].map<Widget>((imageUrl) {
              return SizedBox(
                width: 300,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              );
            }).toList(),
          ),
          Text(
            product['title'],
            style: TextStyle(color: _getTextColor(context), fontSize: 20),
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
                    text: product['description'],
                    style: TextStyle(
            color: _getTextColor(context),
            fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 70),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Row(
                    children: [
                      Text("FREE DELIVERY",style: TextStyle(
                            color: _getTextColor(context),
                            fontWeight: FontWeight.bold,
                          ),),
                          const Icon(Icons.card_travel),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _getTextColor2(context),
        child: Container(
          height: 56.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _getTextColor(context),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(
                      images: product["images"][0],
                      title: product['title'],
                      price: product['price'],
                    ),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                  color: _getTextColor2(context),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    'ADD TO CART',
                    style: TextStyle(
                      color: _getTextColor(context),
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
                color: _getTextColor2(context),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  'ADD TO WISHLIST',
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
