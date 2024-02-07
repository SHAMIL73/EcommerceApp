import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/Razorpay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/Controller/Providers/CartProvider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;

  razorpay razorpayinstance = razorpay();
  @override
  void initState() {
    super.initState();
    razorpayinstance.handles(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: cartProvider.getCartList(),
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
                List<Map<String, dynamic>> cartList = snapshot.data!;
                calculateTotalPrice(cartList);

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> product = cartList[index];

                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              cartProvider
                                  .removeFromCart(product['id'].toString());
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: Image.network(product['thumbnail']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 60),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 50,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              razorpayinstance.createOrder(context, totalPrice);
                            },
                            child: const Text('Buy Now'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  void calculateTotalPrice(List<Map<String, dynamic>> cartList) {
    totalPrice = 0;
    for (var product in cartList) {
      // Check if price is not null and set a default quantity of 1 if it's null
      double quantity = product['quantity'] ?? 1;

      // Check if price is not null before performing the multiplication
      if (product['price'] != null) {
        totalPrice += (product['price'] * quantity);
      }
    }
  }
}