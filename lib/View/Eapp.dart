import 'package:flutter/material.dart';
import 'package:flutter_application_2/Const/Color.dart';
import 'package:flutter_application_2/Model/ApiController.dart';
import 'package:flutter_application_2/Controller/DarkModeGetx.dart';
import 'package:flutter_application_2/View/ProductDetails.dart';
import 'package:flutter_application_2/Controller/ApiProvider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Eapp extends StatefulWidget {
  const Eapp({Key? key}) : super(key: key);

  @override
  State<Eapp> createState() => _EappState();
}

class _EappState extends State<Eapp> {
  late Color textColor;
  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    Get.put(DarkModeGetx());
    Provider.of<ApiProvider>(context, listen: false).fetchDataFromApi();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        title: Text(
          'Eapp',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
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
                updateThemeColors(); // Update colors on theme change
              },
            ),
          ),
        ],
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisExtent: 250,
        ),
        itemCount: Provider.of<ApiProvider>(context).fetchData.products.length,
        itemBuilder: (context, index) {
          Product product =
              Provider.of<ApiProvider>(context).fetchData.products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsDetails(product: product),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                color: textColor,
                child: GridTile(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.network(
                            product.thumbnail,
                          ),
                        ),
                      ),
                      Text(
                        product.brand,
                        style: TextStyle(
                          color: getTextColor2(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 55),
                            child: Text(
                              '\$${product.price}',
                              style: TextStyle(
                                color: getTextColor2(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.favorite ,
                          color: getTextColor2())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: getTextColor2(),
                          ),
                          Text(
                            '${product.rating}',
                            style: TextStyle(
                              color: getTextColor2(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}