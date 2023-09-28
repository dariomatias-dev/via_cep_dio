import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormFieldPropertyModel {
  FormFieldPropertyModel({
    required this.fieldTitle,
    required this.hintText,
    required this.fieldController,
    this.isRequired = true,
    this.maxLength,
    this.mask,
    this.keyboardType,
    this.onChanged,
    this.inputFormatter,
    this.exactCharacterCount,
    required this.validateValue,
    required this.inputFocusNode,
    required this.handleOnDone,
  });

  final String fieldTitle;
  final String hintText;
  final TextEditingController fieldController;
  final bool isRequired;
  final int? maxLength;
  final MaskTextInputFormatter? mask;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextInputFormatter? inputFormatter;
  final int? exactCharacterCount;
  final String? Function(
    String fieldTitle,
    bool isRequired,
    String? value,
    int? exactCharacterCount,
  ) validateValue;
  final FocusNode inputFocusNode;
  final VoidCallback handleOnDone;
}
