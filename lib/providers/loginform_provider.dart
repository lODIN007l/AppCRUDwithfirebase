import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoadingGet => _isLoading;
  set isLoadingSet(bool value) {
    _isLoading = true;
    notifyListeners();
  }

  bool isValidForm() {
    print(formkey.currentState?.validate());
    print('$email-$password');
    return formkey.currentState?.validate() ?? false;
  }
}
