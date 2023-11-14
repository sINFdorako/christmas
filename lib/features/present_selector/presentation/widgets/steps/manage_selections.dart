import 'package:christmas/features/present_selector/presentation/providers/selections_provider.dart';
import 'package:christmas/features/present_selector/presentation/widgets/build_custom_toggle_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageSelections extends ConsumerWidget {
  const ManageSelections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return showOptions(ref, context);
  }

  Widget showOptions(WidgetRef ref, BuildContext context) {
    final selections = ref.watch(selectionsProvider);

    return Column(
      children: [
        const Text(
          'Wähle die Persönlichkeitsmerkmale, die am besten auf die zu beschenkende Person zutreffen.',
        ),
        const SizedBox(height: 16),
        _buildToggleButtons(
          ref,
          context: context,
          labels: ['Neugierig', 'Zuverlässig', 'Gesellig'],
          selections: selections,
        ),
        const SizedBox(height: 16),
        _buildToggleButtons(
          ref,
          context: context,
          labels: ['Hilfsbereit', 'Ruhig', 'Organisiert'],
          selections: selections,
        ),
        const SizedBox(height: 16),
        _buildToggleButtons(
          ref,
          context: context,
          labels: ['Kreativ', 'Mutig', 'Mitfühlend'],
          selections: selections,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildToggleButtons(WidgetRef ref,
      {required BuildContext context,
      required List<String> labels,
      required Map<String, bool> selections}) {
    return BuildCustomToggleButtons().build(
      context: context,
      labels: labels,
      selections: selections,
      onPressed: (String label) {
        ref.read(selectionsProvider.notifier).update((state) {
          final newState = Map<String, bool>.from(state);
          newState[label] = !newState[label]!;
          return newState;
        });
      },
    );
  }
}
