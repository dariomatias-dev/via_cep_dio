import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

import 'package:via_cep_dio/src/utils/input_border_style.dart';

class ViaCepFormFieldWidget extends StatefulWidget {
  const ViaCepFormFieldWidget({
    super.key,
    required this.formFieldProperties,
  });

  final FormFieldPropertyModel formFieldProperties;

  @override
  State<ViaCepFormFieldWidget> createState() => _ViaCepFormFieldWidgetState();
}

class _ViaCepFormFieldWidgetState extends State<ViaCepFormFieldWidget> {
  ValueNotifier<String?> fieldErrorNotifier = ValueNotifier<String?>(null);

  String? validateFormFieldValue() {
    final FormFieldPropertyModel(
      :validateValue,
      :fieldTitle,
      :isRequired,
      :fieldController,
      :exactCharacterCount,
    ) = widget.formFieldProperties;

    final validationResult = validateValue(
      fieldTitle,
      isRequired,
      fieldController.text,
      exactCharacterCount,
    );

    fieldErrorNotifier.value = validationResult;
    return validationResult;
  }

  List<TextInputFormatter> get _inputFormatters => [
        if (widget.formFieldProperties.mask != null)
          widget.formFieldProperties.mask!,
        if (widget.formFieldProperties.inputFormatter != null)
          widget.formFieldProperties.inputFormatter!,
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
    ) = widget.formFieldProperties;

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
              focusNode: widget.formFieldProperties.inputFocusNode,
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
              onChanged: (value) {
                if (onChanged != null) onChanged(value);

                validateFormFieldValue();
              },
              onEditingComplete: () {
                final validationResult = validateFormFieldValue();

                if (validationResult == null) {
                  handleOnDone(fieldTitle);
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
