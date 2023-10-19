import 'package:flutter/material.dart';

import 'package:cep_dio/src/models/form_field_property_model.dart';

import 'package:cep_dio/src/screens/cep_form_screen/components/cep_form_screen_field_widget/cep_form_screen_field_input_widget.dart';

class CepFormFieldWidget extends StatelessWidget {
  const CepFormFieldWidget({
    super.key,
    required this.formFieldProperties,
    required this.getFormFieldProperties,
  });

  final FormFieldPropertyModel formFieldProperties;
  final List<FormFieldPropertyModel> getFormFieldProperties;

  @override
  Widget build(BuildContext context) {
    final FormFieldPropertyModel(
      :fieldTitle,
      :isRequired,
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
        CepFormFieldInputWidget(
          formFieldProperties: formFieldProperties,
          getFormFieldProperties: getFormFieldProperties,
        ),
      ],
    );
  }
}
