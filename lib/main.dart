import 'package:converter/src/controller/api_conversor_controller.dart';
import 'package:converter/src/controller/local_conversor_controller.dart';
import 'package:converter/src/view/api_conversor_view/api_conversor_page.dart';
import 'package:converter/src/view/home_view/home_page.dart';
import 'package:converter/src/view/local_conversor_view/local_conversor_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalConversorController()),
        ChangeNotifierProvider(create: (context) => ApiConversorController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const HomePage(),
          '/local': (context) => const LocalConversorPage(),
          '/api': (context) => const ApiConversorPage(),
        },
      ),
    );
  }
}
