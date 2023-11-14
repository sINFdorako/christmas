import 'package:christmas/features/present_selector/presentation/pages/form_input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geschenkefinder',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF60a0b0), // Ihr Hauptfarbton
          onPrimary: Colors.white, // Textfarbe auf der primären Farbe
          secondary: Color(0xFF634258), // Ihr Sekundärfarbton
          onSecondary: Colors.white, // Textfarbe auf der sekundären Farbe
          error: Color(0xFFB00020), // Standard-Fehlerfarbe
          onError: Colors.white, // Textfarbe auf Fehlerfarbe
          background: Color(0xFF6d6087), // Hintergrundfarbe
          onBackground: Colors.white, // Textfarbe auf dem Hintergrund
          surface: Color(0xFF634258), // Oberflächenfarbe
          onSurface: Colors.white, // Textfarbe auf der Oberfläche
        ),
        useMaterial3: true,
      ),
      home: const FormInputPage(),
    );
  }
}
