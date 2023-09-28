import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

import 'package:via_cep_dio/src/utils/input_border_style.dart';

class ViaCepFormFieldWidget extends StatelessWidget {
  const ViaCepFormFieldWidget({
    super.key,
    required this.formFieldsProperty,
  });

  final FormFieldPropertyModel formFieldsProperty;

  List<TextInputFormatter> get _inputFormatters => [
        if (formFieldsProperty.mask != null) formFieldsProperty.mask!,
        if (formFieldsProperty.inputFormatter != null)
          formFieldsProperty.inputFormatter!,
      ];

  @override
  Widget build(BuildContext context) {
    final FormFieldPropertyModel(
      :fieldTitle,
      :hintText,
      :fieldController,
      :isRequired,
      :maxLength,
      :keyboardType,
      :onChanged,
      :exactCharacterCount,
      :validateValue,
      :handleOnDone,
    ) = formFieldsProperty;

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
          focusNode: formFieldsProperty.inputFocusNode,
          inputFormatters:
              _inputFormatters.isNotEmpty ? _inputFormatters : null,
          keyboardType: keyboardType,
          validator: (value) => validateValue(
            fieldTitle,
            isRequired,
            value,
            exactCharacterCount,
          ),
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          onChanged: onChanged,
          onEditingComplete: () {
            final validationResult = validateValue(
              fieldTitle,
              isRequired,
              fieldController.text,
              exactCharacterCount,
            );

            if (validationResult == null) {
              handleOnDone(fieldTitle);
            }
          },
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }
}
