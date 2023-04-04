import 'package:flutter/material.dart';
import 'package:jwt_login_register/pages/home_page.dart';
import 'package:jwt_login_register/pages/login_page.dart';
import 'package:jwt_login_register/pages/register_page.dart';
import 'package:jwt_login_register/services/shared_service.dart';

Widget defaultHome = const LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool result = await SharedService.isLoggedIn();
  if (result) {
    defaultHome = const HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      routes: {
        "/": (context) => defaultHome,
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage()
      },
    );
  }
}
