import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:via_cep_dio/src/utils/input_border_style.dart';

class AddViaCepScreenFormFieldWidget extends StatelessWidget {
  const AddViaCepScreenFormFieldWidget({
    super.key,
    required this.fieldTitle,
    required this.hintText,
    required this.fieldController,
    this.isRequired = true,
    this.maxLength,
    this.mask,
    this.keyboardType,
    this.onChanged,
    this.inputFormatter,
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

  List<TextInputFormatter> get _inputFormatters => [
        if (mask != null) mask!,
        if (inputFormatter != null) inputFormatter!,
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$fieldTitle:',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red.shade400,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 2.0),
        TextFormField(
          controller: fieldController,
          inputFormatters:
              _inputFormatters.isNotEmpty ? _inputFormatters : null,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || (isRequired && value.trim().isEmpty)) {
              return 'Insirá algum valor';
            }

            return null;
          },
          maxLength: maxLength,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 10.0,
            ),
            hintText: hintText,
            enabledBorder: inputBorderStyle(Colors.grey).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: inputBorderStyle(Colors.black).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedErrorBorder: inputBorderStyle(Colors.red).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorBorder: inputBorderStyle(Colors.red).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: onChanged,
        ),
      ],
    );
  }
}
