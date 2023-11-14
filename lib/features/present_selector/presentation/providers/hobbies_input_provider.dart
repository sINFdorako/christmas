import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hobbiesInputProvider = StateNotifierProvider<HobbiesController,
    Map<String, TextEditingController>>((ref) {
  return HobbiesController();
});

class HobbiesController
    extends StateNotifier<Map<String, TextEditingController>> {
  HobbiesController()
      : super({
          'hobby1': TextEditingController(),
          'hobby2': TextEditingController()
        });

  @override
  void dispose() {
    state.forEach((key, controller) => controller.dispose());
    super.dispose();
  }
}
