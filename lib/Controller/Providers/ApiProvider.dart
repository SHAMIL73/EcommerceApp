import 'package:flutter/material.dart';
import 'package:flutter_application_2/Model/ApiClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider extends ChangeNotifier {
  late ApiClass fetchData =
      ApiClass(products: [], total: 0, skip: 0, limit: 0);

  Future<void> fetchDataFromApi() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        final Map<String, dynamic> data = json.decode(response.body);
        // print("Response Data: $data");

        fetchData = ApiClass.fromJson(data);
// print("fetchData: $fetchData");
        notifyListeners();
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle exceptions
      print("Error: $e");
    }
  }
   List<Product> myList = [];
   
  searching(String keyWord) {
    myList = fetchData.products
        .where((item) => item.title.toLowerCase().startsWith(keyWord))
        .toList();
    notifyListeners();
  }
}