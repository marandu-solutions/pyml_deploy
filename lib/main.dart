import 'package:flutter/material.dart';
import 'package:pyml/Pages/Initial%20Page/initial_page.dart';
import 'package:pyml/Pages/Register_page/register_page.dart';

import 'Pages/LoginPage/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InitialPage(),  // Rota para a tela inicial
        '/login': (context) => LoginPage(), // Rota para a tela de login
        '/cadastro': (context) => RegisterPage(), // Rota para a tela de cadastro
      },
    );
  }
}
