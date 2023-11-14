import 'package:christmas/features/present_selector/presentation/providers/job_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/widgets/build_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputProfession extends ConsumerWidget {
  const InputProfession({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final job = ref.watch(jobInputProvider);

    return Column(
      children: [
        const Text(
            'Bitte nenne den Beruf der zu beschenkenden Person, falls sie mit dieser Wahl bereits glücklich ist. Alternativ gib den Traumberuf an den diese Person gerne hätte.'),
        BuildTextInput().build(job, 'Beruf'),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
