import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/via_cep_form_screen_field_widget/validate_value.dart';

import 'package:via_cep_dio/src/utils/input_border_style.dart';

class ViaCepFormFieldWidget extends StatelessWidget {
  ViaCepFormFieldWidget({
    super.key,
    required this.formFieldProperties,
    required this.getFormFieldProperties,
  });

  final FormFieldPropertyModel formFieldProperties;
  final List<FormFieldPropertyModel> getFormFieldProperties;

  final ValueNotifier<String?> fieldErrorNotifier =
      ValueNotifier<String?>(null);

  String? _validateFormFieldValue({bool shouldUpdateValidValue = true}) {
    final FormFieldPropertyModel(
      :setValidValue,
    ) = formFieldProperties;

    final validationResult = validateValue(formFieldProperties);

    if (shouldUpdateValidValue) setValidValue(validationResult == null);

    fieldErrorNotifier.value = validationResult;
    return validationResult;
  }

  List<TextInputFormatter> get _inputFormatters => [
        if (formFieldProperties.mask != null) formFieldProperties.mask!,
        if (formFieldProperties.inputFormatter != null)
          formFieldProperties.inputFormatter!,
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
      :handleOnDone,
    ) = formFieldProperties;

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
        ListenableBuilder(
          listenable: fieldErrorNotifier,
          builder: (context, child) {
            return TextFormField(
              controller: fieldController,
              focusNode: formFieldProperties.inputFocusNode,
              inputFormatters:
                  _inputFormatters.isNotEmpty ? _inputFormatters : null,
              keyboardType: keyboardType,
              maxLength: maxLength,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 10.0,
                ),
                hintText: hintText,
                errorText: fieldErrorNotifier.value,
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
              validator: (value) {
                _validateFormFieldValue(
                  shouldUpdateValidValue: false,
                );
                return null;
              },
              onChanged: (value) {
                if (onChanged != null) onChanged(value);

                _validateFormFieldValue();
              },
              onEditingComplete: () {
                final validationResult = _validateFormFieldValue();

                if (validationResult == null) {
                  handleOnDone(
                    fieldTitle,
                    getFormFieldProperties,
                  );
                }
              },
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            );
          },
        ),
      ],
    );
  }
}
