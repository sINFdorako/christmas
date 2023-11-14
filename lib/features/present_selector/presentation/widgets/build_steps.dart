import 'package:christmas/features/present_selector/presentation/widgets/steps/input_past_presents.dart';
import 'package:christmas/features/present_selector/presentation/widgets/steps/input_profession.dart';
import 'package:christmas/features/present_selector/presentation/widgets/steps/manage_selections.dart';
import 'package:christmas/features/present_selector/presentation/widgets/steps/input_age_gender.dart';
import 'package:christmas/features/present_selector/presentation/widgets/steps/input_hobbies.dart';
import 'package:flutter/material.dart';

class BuildSteps {
  List<Step> build({
    required int currentStep,
  }) {
    return [
      Step(
        title: const Text('Alter & Geschlecht'),
        content: const InputAgeAndGender(),
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Hobbys'),
        content: const InputHobbies(),
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Persönlichkeit'),
        content: const ManageSelections(),
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Beruf'),
        content: const InputProfession(),
        isActive: currentStep >= 3,
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Vergangene Geschenke'),
        content: const InputPastPresents(),
        isActive: currentStep >= 4,
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
      ),
    ];
  }
}
