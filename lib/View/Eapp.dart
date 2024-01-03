import 'package:flutter/material.dart';
import 'package:flutter_application_2/Model/ApiController.dart';
import 'package:flutter_application_2/Controller/DarkModeProvider.dart';
import 'package:flutter_application_2/View/ProductDetails.dart';
import 'package:flutter_application_2/Controller/ApiProvider.dart';
import 'package:provider/provider.dart';

class Eapp extends StatefulWidget {
  const Eapp({Key? key}) : super(key: key);

  @override
  State<Eapp> createState() => _EappState();
}

class _EappState extends State<Eapp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(child: liSt()),
    );
  }
}

class liSt extends StatefulWidget {
  const liSt({Key? key}) : super(key: key);

  @override
  State<liSt> createState() => _liStState();
}


class _liStState extends State<liSt> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).fetchDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    Color getTextColor(BuildContext context) {
      final isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
      final backgroundColor = isDarkMode ? Colors.black : Colors.white;
      final luminance = backgroundColor.computeLuminance();
      return luminance > 0.5 ? Colors.black : Colors.white;
    }
    Color getTextColor2(BuildContext context) {
      final isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
      final backgroundColor = isDarkMode ? Colors.white : Colors.black;
      final luminance = backgroundColor.computeLuminance();
      return luminance > 0.5 ? Colors.black : Colors.white;
    }

    return Scaffold(
        backgroundColor: Provider.of<DarkModeProvider>(context).isDarkMode
            ? Colors.black
            : Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          title: Text(
            'Eapp',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: getTextColor(context),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Consumer<DarkModeProvider>(
                builder: (context, themeProvider, child) {
                  return IconButton(
                    icon: Icon(
                      themeProvider.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      size: 30,
                      color: getTextColor(context),
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
        body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
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
                    builder: (context) =>
                        ProductsDetails(product:product),
                  ),
                );
              },

              //////////////////////////////////////////////////////////////////////////////////
              ///
              ///
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(color: getTextColor(context),
                  child: GridTile(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: Image.network(
                            product.thumbnail,
                          ),
                        ),
                        Text(
                          product.brand,
                          style: TextStyle(
                            color: getTextColor2(context),
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
                                  color: getTextColor2(context),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(Icons.favorite)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: getTextColor2(context),
                            ),
                            Text(
                              '${product.rating}',
                              style: TextStyle(
                                color: getTextColor2(context),
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
        ));
  }
}