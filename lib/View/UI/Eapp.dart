import 'package:flutter/material.dart';
import 'package:flutter_application_2/Model/ApiClass.dart';
import 'package:flutter_application_2/Controller/Getx/DarkModeGetx.dart';
import 'package:flutter_application_2/View/UI/ProductDetails.dart';
import 'package:flutter_application_2/Controller/Providers/ApiProvider.dart';
import 'package:flutter_application_2/View/UI/Search.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import CarouselSlider

class Eapp extends StatefulWidget {
  const Eapp({Key? key}) : super(key: key);

  @override
  State<Eapp> createState() => _EappState();
}

class _EappState extends State<Eapp> {
  @override
  void initState() {
    super.initState();
    Get.put(DarkModeGetx());
    Provider.of<ApiProvider>(context, listen: false).fetchDataFromApi();
    updateThemeColors();
  }

  void updateThemeColors() {
    setState(() {
      getTextColor();
    });
  }

  Color getTextColor() {
    return Get.find<DarkModeGetx>().isDarkMode ? Colors.white : Colors.black;
  }

  Color getTextColor2() {
    return Get.find<DarkModeGetx>().isDarkMode ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTextColor2(),
      appBar: AppBar(
        backgroundColor: getTextColor(),
        title: Row(
          children: [
            Text(
              'Eapp',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: getTextColor2(),
              ),
            ),
            GestureDetector(
              onTap: () =>
             Navigator.push(context,
            MaterialPageRoute(builder:(context) => SearchPage())
            ),            
              child: Container(
                height: 30,
                margin: EdgeInsets.only(left: 25),
                width: 240,
                decoration: BoxDecoration(
                  border: Border.all(color: getTextColor2()),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Icon(Icons.search, color: getTextColor2()),
                alignment: Alignment.topRight,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                Get.find<DarkModeGetx>().isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
                size: 30,
                color: getTextColor2(),
              ),
              onPressed: () {
                Get.find<DarkModeGetx>().toggleTheme();
                updateThemeColors(); // Update colors on theme change
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: getTextColor(),
            child: SizedBox(
              height: 240,
              child: CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  viewportFraction: 2.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: Provider.of<ApiProvider>(context)
                    .fetchData
                    .products
                    .map<Widget>((product) {
                  return SizedBox(
                    width: 300,
                    child: Image.network(product.thumbnail, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                mainAxisExtent: 250,
              ),
              itemCount:
                  Provider.of<ApiProvider>(context).fetchData.products.length,
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
                      color: getTextColor(),
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
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
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
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Icon(
                                    Icons.star,
                                    color: getTextColor2(),
                                  ),
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
          ),
        ],
      ),
    );
  }
}