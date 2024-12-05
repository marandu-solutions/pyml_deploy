import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pyml/Pages/Home_Page/home_page.dart';
import 'package:pyml/Pages/Initial%20Page/initial_page.dart';
import 'package:pyml/Pages/LoginPage/login_page.dart';
import 'package:pyml/Pages/Register_page/register_page.dart';
import 'package:provider/provider.dart';
import 'package:pyml/Providers/user_provider.dart';
import 'firebase_options.dart'; // Importando o arquivo gerado pelo FlutterFire CLI

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase com as opções corretas
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ativar Firebase App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    webProvider: ReCaptchaV3Provider('6LfhhpMqAAAAADdD7Jx6WgtluE0wMThMwz4MmCoN'),
  );

  // Inicializar o UserProvider com tratamento de erro
  final userProvider = UserProvider();
  try {
    await userProvider.loadUser();
  } catch (e) {
    print('Erro ao carregar usuário: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => userProvider,
      child: MyApp(userProvider: userProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserProvider userProvider;

  MyApp({required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Redirecionar para a tela correta com base no estado do usuário
      home: userProvider.isLoggedIn ? HomePage() : InitialPage(),
      routes: {
        '/login': (context) => LoginPage(), // Rota para a tela de login
        '/cadastro': (context) => RegisterPage(), // Rota para a tela de cadastro
      },
    );
  }
}
