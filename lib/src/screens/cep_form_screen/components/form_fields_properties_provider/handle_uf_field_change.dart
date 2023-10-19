import 'package:flutter/material.dart';

void handleUfFieldChange(TextEditingController ufFieldController) {
  final value = ufFieldController.text;
  final formattedValue = value.toUpperCase();
  ufFieldController.value = ufFieldController.value.copyWith(
    text: formattedValue,
    selection: TextSelection.collapsed(
      offset: formattedValue.length,
    ),
  );
}
