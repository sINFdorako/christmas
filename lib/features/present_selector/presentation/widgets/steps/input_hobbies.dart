import 'package:christmas/features/present_selector/presentation/providers/hobbies_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/widgets/build_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputHobbies extends ConsumerWidget {
  const InputHobbies({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hobby1 = ref.watch(hobbiesInputProvider)['hobby1']!;
    final hobby2 = ref.watch(hobbiesInputProvider)['hobby2']!;

    return Column(
      children: [
        const Text(
            'Bitte gib zwei Hobbys oder Interessen der zu beschenkenden Person ein.'),
        BuildTextInput().build(hobby1, 'Hobby oder Interesse 1'),
        BuildTextInput().build(hobby2, 'Hobby oder Interesse 2'),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
