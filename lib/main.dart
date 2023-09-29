import 'package:aplikasi_pengelola_keuangan/konstan/route_constant.dart';
import 'package:aplikasi_pengelola_keuangan/pages/home.dart';
import 'package:aplikasi_pengelola_keuangan/login.dart';
import 'package:aplikasi_pengelola_keuangan/controller/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => LoginPage(),
  homeRoute: (BuildContext context) => Home(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cashflow App",
      routes: routes,
    );
  }
}
