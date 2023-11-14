import 'package:flutter/material.dart';

class BuildTextInput {
  Widget build(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(.8)),
          floatingLabelStyle: const TextStyle(color: Colors.white)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte fülle dieses Feld aus oder überspringe es.';
        }
        return null;
      },
    );
  }
}
