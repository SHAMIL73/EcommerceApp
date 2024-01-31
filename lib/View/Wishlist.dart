import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/Controller/WishProvider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Consumer<WishProvider>(
        builder: (context, WishProvider, _) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: WishProvider.getWishList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>> cartlist2 = snapshot.data!;

                return ListView.builder(
                  itemCount: cartlist2.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> product = cartlist2[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        // Remove item from cart when dismissed
                        WishProvider.removeFromWish(product['id'].toString());
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Image.network(product['thumbnail']),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 50,
                                  width: 138,
                                    child: Text(
                                      product['title'],
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      'Price: \$${product['price']}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              '<<REMOVE',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}