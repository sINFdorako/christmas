import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobInputProvider =
    StateNotifierProvider<JobController, TextEditingController>((ref) {
  return JobController();
});

class JobController extends StateNotifier<TextEditingController> {
  JobController() : super(TextEditingController());

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
