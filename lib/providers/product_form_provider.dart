import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProviderr extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;
  ProductFormProviderr(this.product);

  updateDisponible(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);

    return formKey.currentState?.validate() ?? false;
  }
}
