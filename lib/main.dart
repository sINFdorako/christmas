import 'package:christmas/features/present_selector/presentation/pages/present_selector_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0C8B51)),
        useMaterial3: true,
      ),
      home: const PresentSelectorPage(),
    );
  }
}
