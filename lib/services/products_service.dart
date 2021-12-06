import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/products.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-aa9ee-default-rtdb.firebaseio.com';

  final List<Product> products = [];
  bool isLoading = true;

  bool isSaving = false;
  //producto seleccionado
  late Product selectedproducto;

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

  Future SaveORcreateProducr(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //es necesario crear
      await this.CreateProduc(product);
    } else {
      //actualizar
      await this.updateProduc(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduc(Product product) async {
    //enviamos mediante el id los nuevos datos
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    //y enviamos mediante el "put"
    final resp = await http.put(url, body: product.toJson());

    final decodeData = resp.body;

    //TODO ACTUALIZAR EL LISTADO DE PRODUCTOS en base a la lista
    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    print(decodeData);
    return product.id!;
  }

  Future<String> CreateProduc(Product product) async {
    //enviamos mediante el id los nuevos datos
    final url = Uri.https(_baseUrl, 'products.json');
    //y enviamos mediante el "put"
    final resp = await http.post(url, body: product.toJson());
    //convertimos el resp.body en un mapa para tomar el name para id
    final decodeData = json.decode(resp.body);
    product.id = decodeData['name'];
    this.products.add(product);

    return product.id!;
  }

  //TODO hacer fetch de productos
}
