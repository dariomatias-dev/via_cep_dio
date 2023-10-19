import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

import 'package:via_cep_dio/src/screens/cep_form_screen/components/cep_form_screen_field_widget/cep_form_screen_field_widget.dart';

class CepFormFielsdWidget extends StatefulWidget {
  const CepFormFielsdWidget({
    super.key,
    required this.formFieldsProperties,
  });

  final List<FormFieldPropertyModel> formFieldsProperties;

  @override
  State<CepFormFielsdWidget> createState() => _CepFormFielsdWidgetState();
}

class _CepFormFielsdWidgetState extends State<CepFormFielsdWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.formFieldsProperties[0].inputFocusNode.requestFocus();
    });
    super.initState();
  }

  List<FormFieldPropertyModel> get getFormFieldProperties =>
      widget.formFieldsProperties;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.formFieldsProperties.length,
      itemBuilder: (context, index) {
        final FormFieldPropertyModel formFieldProperties =
            getFormFieldProperties[index];

        return Padding(
          padding: EdgeInsets.only(
            bottom: formFieldProperties.maxLength != null ? 0.0 : 10.0,
          ),
          child: CepFormFieldWidget(
            formFieldProperties: formFieldProperties,
            getFormFieldProperties: getFormFieldProperties,
          ),
        );
      },
    );
  }
}
