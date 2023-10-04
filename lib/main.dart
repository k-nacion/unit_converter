import 'package:flutter/material.dart';
import 'package:unit_converter/homepage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFecc986)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
