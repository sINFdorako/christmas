import 'package:christmas/features/present_selector/presentation/helper/create_prompt.dart';
import 'package:christmas/features/present_selector/presentation/pages/results_present_page.dart';
import 'package:christmas/features/present_selector/presentation/providers/age_gender_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/providers/current_step_provider.dart';
import 'package:christmas/features/present_selector/presentation/providers/hobbies_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/providers/job_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/providers/past_presents_input_provider.dart';
import 'package:christmas/features/present_selector/presentation/providers/selections_provider.dart';
import 'package:christmas/features/present_selector/presentation/widgets/build_steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormInputPage extends ConsumerWidget {
  const FormInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentStepProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Geschenkefinder',
          style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 700,
              child: Center(
                child: Stepper(
                  physics: const NeverScrollableScrollPhysics(),
                  currentStep: currentStep,
                  controlsBuilder: (context, details) =>
                      _buildStepperControls(context, details, currentStep, ref),
                  onStepContinue: () =>
                      _onStepContinue(ref, context, currentStep),
                  onStepCancel: () => _onStepCancel(ref),
                  steps: BuildSteps().build(currentStep: currentStep),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperControls(BuildContext context, ControlsDetails details,
      int currentStep, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (currentStep != 0)
          TextButton(
            onPressed: details.onStepCancel,
            child: const Text('Zurück', style: TextStyle(fontSize: 13.5)),
          ),
        if (currentStep <
            BuildSteps().build(currentStep: currentStep).length - 1)
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: const Text('Nächster Schritt',
                style: TextStyle(fontSize: 13.5)),
          ),
        if (currentStep ==
            BuildSteps().build(currentStep: currentStep).length - 1)
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _copyPrompt(context, ref),
                child: const Row(
                  children: [
                    Icon(Icons.copy),
                    Text('Prompt', style: TextStyle(fontSize: 13.5)),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () => _onStepComplete(context, ref),
                child: const Text(
                  'Fertig',
                  style: TextStyle(fontSize: 13.5),
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _onStepContinue(WidgetRef ref, BuildContext context, int currentStep) {
    final totalSteps = BuildSteps().build(currentStep: currentStep).length;

    if (currentStep < totalSteps - 1) {
      ref.read(currentStepProvider.notifier).state = currentStep + 1;
    }
  }

  _onStepCancel(WidgetRef ref) {
    final currentStep = ref.read(currentStepProvider.notifier).state;

    if (currentStep > 0) {
      ref.read(currentStepProvider.notifier).state = currentStep - 1;
    }
  }

  _onStepComplete(BuildContext context, WidgetRef ref) {
    {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsPresentPage(
                  prompt: _getPrompt(ref),
                )),
      );
    }
  }

  _copyPrompt(BuildContext context, WidgetRef ref) {
    Clipboard.setData(ClipboardData(text: _getPrompt(ref))).then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Prompt in die Zwischenablage kopiert!')),
        );
      },
    );
  }

  String _getPrompt(WidgetRef ref) {
    final age = ref.watch(ageGenderInputProvider)['age'];
    final gender = ref.watch(ageGenderInputProvider)['gender'];
    final hobby1 = ref.watch(hobbiesInputProvider)['hobby1'];
    final hobby2 = ref.watch(hobbiesInputProvider)['hobby2'];
    final job = ref.watch(jobInputProvider);
    final pastPresent1 = ref.watch(pastPresentsInputProvider)['present1'];
    final pastPresent2 = ref.watch(pastPresentsInputProvider)['present2'];
    final selections = ref.watch(selectionsProvider);

    final prompt = CreatePrompt().build(
        gender: gender?.text.trim() ?? '',
        age: age?.text.trim() ?? '',
        hobby1: hobby1?.text.trim() ?? '',
        hobby2: hobby2?.text.trim() ?? '',
        job: job.text.trim(),
        pastPresent1: pastPresent1?.text.trim() ?? '',
        pastPresent2: pastPresent2?.text.trim() ?? '',
        selections: selections);

    return prompt;
  }
}
