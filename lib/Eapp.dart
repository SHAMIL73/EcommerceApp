// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ProductDetails.dart';
import 'package:flutter_application_2/ProviderDemo.dart';
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
    Provider.of<ProviderClass>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Provider.of<ProviderClass>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Text(
          'Eapp',
          style: TextStyle(fontWeight: FontWeight.w500,
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
      body: Consumer<ProviderClass>(
        builder: (context, api, child) {
          return api.products.isNotEmpty
              ? GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 250,
                  ),
                  itemCount: api.products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductsDetails(product: api.products[index]),
                          ),
                        );
                        print('workking');
                      },
                      child: GridTile(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 160,
                                  child: Image.network(
                                    '${api.products[index]['thumbnail']}',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${api.products[index]['title']}',
                                  style: TextStyle(
                                    color: _getTextColor(context),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 55),
                                  child: Text(
                                    "\$${api.products[index]['price']}",
                                    style: TextStyle(
                                      color: _getTextColor(context),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(Icons.favorite)
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: _getTextColor(context),
                                    ),
                                    Text(
                                      '${api.products[index]['rating']}',
                                      style: TextStyle(
                                        color: _getTextColor(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('Loading...'));
        },
        
      ),
      
    );
  }

  Color _getTextColor(BuildContext context) {
    final isDarkMode = Provider.of<ProviderClass>(context).isDarkMode;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;

    // Calculate luminance and choose text color accordingly
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}