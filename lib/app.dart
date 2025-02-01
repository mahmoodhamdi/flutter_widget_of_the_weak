import 'package:flutter/material.dart';
import 'package:flutter_widget_of_the_weak/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      title: 'Flutter Widget of the Week',
      home: const HomeView(),
    );
  }
}
