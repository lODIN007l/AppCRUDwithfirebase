import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProviderr extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;
  ProductFormProviderr(this.product);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
