import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderClass extends ChangeNotifier {
  List<dynamic> myproducts = [];
  
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      myproducts = jsonData['products'];
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
}