import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_udemy_flutter/stores/login_store/login_store.dart';
import 'package:mobx_udemy_flutter/widgets/custom_icon_button.dart';
import 'package:mobx_udemy_flutter/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late LoginStore loginStore;

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);

    // SOBRE AS REAÇÕES
    // E importante sempre dar um dispose nas reações quando não for mais usar
    // para garantir economia nos recursos

    // Esse cara executa a variável logo de cara, inicialmente
    // autorun((_) {
    //   print(loggedIn);
    //   if(loginStore.loggedIn) {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (_) => ListScreen())
    //     );
    //   }
    // });

    // Esse cara executa apenas após a mudança da variável.
    disposer = reaction(
      (_) => loginStore.loggedIn, 
      (loggedIn) {
        print(loggedIn);
        if(loginStore.loggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => ListScreen())
          );
        }
      }
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(
                      builder: (context) {
                        return CustomTextField(
                          hint: 'E-mail',
                          prefix: const Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail,
                          enabled: !loginStore.loading,
                        );
                      }
                    ),
                    const SizedBox(height: 16,),
                    Observer(
                      builder: (context) {
                        return CustomTextField(
                          hint: 'Senha',
                          prefix: const Icon(Icons.lock),
                          obscure: loginStore.showPassword,
                          onChanged: loginStore.setPassword,
                          enabled: !loginStore.loading,
                          suffix: CustomIconButton(
                            radius: 32,
                            iconData: loginStore.showPassword 
                                ? Icons.visibility_off 
                                : Icons.visibility,
                            onTap: () => loginStore.togglePassword()
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: Observer(
                        builder: (context) {
                          return IgnorePointer(
                            ignoring: loginStore.loading,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {

                                  if(states.contains(MaterialState.disabled)) {
                                    return Theme.of(context).primaryColor.withAlpha(100);
                                  }

                                  return Theme.of(context).primaryColor;
                                }),
                                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                )),
                                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                                  color: Colors.white
                                )),
                              ),
                              child: loginStore.loading
                                  ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  )
                                  : const Text('Login'),
                              onPressed: loginStore.loginPressed
                            ),
                          );
                        }
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
