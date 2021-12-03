import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  _LoginStore() {
    
    // Uma reação que é executada sempre que um observable dentro desse cara é alterado ou lido (um tap no input executa esse cara tbm)
    // autorun((_) {
    //   print(email);
    // });
  }

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool showPassword = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void togglePassword() => showPassword = !showPassword;

  @action
  Future<void> login() async {
    loading = true;

    // processar
    await Future.delayed(const Duration(seconds: 2));

    loading = false;

    email = "";
    password = "";

    loggedIn = true;
  }

  @action
  void logout() {
    loggedIn = false;
  }

  // Funciona
  // @computed
  // bool get isFormValid => email.length > 6 && password.length > 6;

  @computed
  bool get isEmailValid => email.length > 6;

  @computed
  bool get isPasswordValid => password.length > 6;

  // Posso combinar computeds
  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  // @computed
  // VoidCallback? get loginPressed => (isEmailValid && isPasswordValid && !loading)
  //     ? login
  //     : null;

  @computed
  VoidCallback? get loginPressed => (isFormValid && !loading)
      ? login
      : null;
}