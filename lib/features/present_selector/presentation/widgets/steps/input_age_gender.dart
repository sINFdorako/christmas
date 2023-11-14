import 'package:christmas/features/present_selector/presentation/providers/age_gender_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/widgets/build_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputAgeAndGender extends ConsumerWidget {
  const InputAgeAndGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final age = ref.watch(ageGenderInputProvider)['age']!;
    final gender = ref.watch(ageGenderInputProvider)['gender']!;

    return Column(
      children: [
        const Text(
            'Bitte gebe das Alter und Geschlecht der Person an. Wenn du es nicht genau weißt reicht eine Schätzung.'),
        BuildTextInput().build(age, 'Alter'),
        BuildTextInput().build(gender, 'Geschlecht'),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
