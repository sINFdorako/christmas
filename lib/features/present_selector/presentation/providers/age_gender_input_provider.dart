import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ageGenderInputProvider = StateNotifierProvider<AgeGenderInputController,
    Map<String, TextEditingController>>((ref) {
  return AgeGenderInputController();
});

class AgeGenderInputController
    extends StateNotifier<Map<String, TextEditingController>> {
  AgeGenderInputController()
      : super({
          'age': TextEditingController(),
          'gender': TextEditingController()
        });

  @override
  void dispose() {
    state.forEach((key, controller) => controller.dispose());
    super.dispose();
  }
}
