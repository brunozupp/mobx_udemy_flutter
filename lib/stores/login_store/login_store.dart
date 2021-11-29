import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  _LoginStore() {
    
    // Uma reação que é executada sempre que um observable dentro desse cara é alterado ou lido (um tap no input executa esse cara tbm)
    autorun((_) {
      print(email);
    });
  }

  @observable
  String email = "";

  @observable
  String password = "";

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;
}