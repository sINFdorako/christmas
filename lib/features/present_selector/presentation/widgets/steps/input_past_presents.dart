import 'package:christmas/features/present_selector/presentation/providers/past_presents_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/widgets/build_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputPastPresents extends ConsumerWidget {
  const InputPastPresents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastPresent1 = ref.watch(pastPresentsInputProvider)['pastPresent1']!;
    final pastPresent2 = ref.watch(pastPresentsInputProvider)['pastPresent2']!;

    return Column(
      children: [
        const Text(
            'Bitte benenne zwei Geschenke über die sich die zu beschenkende Person in der Vergangenheit gefreut hat. Alternativ kannst du angeben was du vermutest worüber sie sich freuen würde.'),
        BuildTextInput().build(pastPresent1, 'Geschenk 1'),
        BuildTextInput().build(pastPresent2, 'Geschenk 2'),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
