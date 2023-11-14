import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pastPresentsInputProvider = StateNotifierProvider<
    PastPresentsInputController, Map<String, TextEditingController>>((ref) {
  return PastPresentsInputController();
});

class PastPresentsInputController
    extends StateNotifier<Map<String, TextEditingController>> {
  PastPresentsInputController()
      : super({
          'pastPresent1': TextEditingController(),
          'pastPresent2': TextEditingController()
        });

  @override
  void dispose() {
    state.forEach((key, controller) => controller.dispose());
    super.dispose();
  }
}
