import 'package:flutter/material.dart';

class BuildCustomToggleButtons {
  Widget build({
    required BuildContext context,
    required List<String> labels,
    required Map<String, bool> selections,
    required void Function(String label) onPressed,
  }) {
    final List<Widget> buttonChildren = labels.map((label) {
      return toggleButton(
        context: context,
        label: label,
        isSelected: selections[label] ?? false,
        onPressed: () => onPressed(label),
      );
    }).toList();

    return SizedBox(
      child: ToggleButtons(
        onPressed: (int index) {
          String label = labels[index];
          onPressed(label);
        },
        isSelected: labels.map((label) => selections[label] ?? false).toList(),
        borderColor: Colors.transparent,
        fillColor: Theme.of(context).colorScheme.secondary.withOpacity(.5),
        selectedBorderColor: Colors.transparent,
        selectedColor: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        children: buttonChildren,
      ),
    );
  }

  Widget toggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return Container(
      alignment: Alignment.center,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white.withOpacity(.8),
          shape: const CircleBorder(),
          padding: const EdgeInsets.only(left: 8.0, right: 8),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
