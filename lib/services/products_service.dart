import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/products.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-aa9ee-default-rtdb.firebaseio.com';

  final List<Product> products = [];
  bool isLoading = true;

  ProductsService() {
    this.loadProducts();
  }

  Future loadProducts() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productosMap = json.decode(resp.body);
    //print(productosMap);
    productosMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
    //print(this.products[0].name);
  }

  //TODO hacer fetch de productos
}
