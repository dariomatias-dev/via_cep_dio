import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormFieldPropertyModel {
  FormFieldPropertyModel({
    required this.fieldTitle,
    required this.hintText,
    required this.fieldController,
    required this.isRequired,
    this.maxLength,
    this.mask,
    this.keyboardType,
    this.onChanged,
    this.inputFormatter,
    this.validation,
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
  final bool Function(String?)? validation;
}
