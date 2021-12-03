import 'package:flutter/material.dart';
import 'package:mobx_udemy_flutter/screens/list_screen.dart';
import 'package:mobx_udemy_flutter/screens/login_screen.dart';
import 'package:mobx_udemy_flutter/stores/login_store/login_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.deepPurpleAccent,
            selectionColor: Colors.deepPurpleAccent,
            selectionHandleColor: Colors.deepPurpleAccent,  
          ),
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: LoginScreen(),
      ),
    );
  }
}