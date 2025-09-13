import 'package:untitled1/pages/%20my_cart_page.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart' hide MyCartPage;
import 'pages/product_details.dart' hide MyCartPage;
import 'pages/my_cart_page.dart';
import 'pages/account_page.dart';
import 'pages/address_page.dart';
import 'pages/logout_page.dart' hide AccountPage;

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/cart': (context) => MyCartPage(cartItems: const []),
        '/account': (context) => const AccountPage(),
        '/address': (context) => const AddressPage(),
        '/logout': (context) => const LogoutPage(),
      },
    );
  }
}