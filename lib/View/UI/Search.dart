import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/Providers/ApiProvider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          constraints: BoxConstraints(
            maxHeight: 45.0,
            maxWidth: 290.0,
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Search Your Products',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(bottom: 8), // Adjust this value
            ),
            onChanged: (value) {
              final apiProvider = context.read<ApiProvider>();
              apiProvider.searching(value);
            },
          ),
        ),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, apiProvider, _) {
          final searchResults = apiProvider.myList;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final product = searchResults[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text(product.description),
                // You can add more information here
              );
            },
          );
        },
      ),
    );
  }
}