import 'dart:io';

enum Authmode { signup, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  Authmode _mode = Authmode.login;

  bool get isLogin {
    return _mode == Authmode.login;
  }

  bool get isSignup {
    return _mode == Authmode.signup;
  }

  void toggleAuthMode() {
    _mode = isLogin ? Authmode.signup : Authmode.login;
  }

  
}
