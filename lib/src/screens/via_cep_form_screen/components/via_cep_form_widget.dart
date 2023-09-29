import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';
import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/form_fields_properties_provider/auto_focus_and_submit_on_done.dart';
import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/via_cep_form_screen_fields_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class ViaCepFormWidget extends StatelessWidget {
  ViaCepFormWidget({
    super.key,
    required this.screenContext,
    required this.formType,
    this.viaCepId,
    required this.formFieldsProperties,
  });

  final BuildContext screenContext;
  final String formType;
  final String? viaCepId;
  final List<FormFieldPropertyModel> formFieldsProperties;

  final ViaCepService viaCepService = ViaCepService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fieldValue(String fieldTitle) {
    return formFieldsProperties
        .firstWhere(
          (formFieldsProperty) {
            return formFieldsProperty.fieldTitle.toLowerCase() == fieldTitle;
          },
        )
        .fieldController
        .text;
  }

  String removeNonDigits(String input) {
    return input.replaceAll(
      RegexHelper.nonDigit,
      '',
    );
  }

  bool _validateForm() {
    final firstFormFieldTitle =
        formFieldsProperties[formFieldsProperties.length - 1].fieldTitle;

    return autoFocusOnDone(
      firstFormFieldTitle,
      formFieldsProperties,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Preencha o formulário',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ViaCepFormFielsdWidget(
              formFieldsProperties: formFieldsProperties,
            ),
            DefaultButtonWidget(
              text: formType == 'creation' ? 'ADICIONAR' : 'ATUALIZAR',
              action: () {
                _formKey.currentState!.validate();

                if (_validateForm()) {
                  Navigator.pop(screenContext);

                  final ViaCepModel viaCep = ViaCepModel(
                    cep: _fieldValue('cep'),
                    logradouro: _fieldValue('logradouro'),
                    complemento: _fieldValue('complemento'),
                    bairro: _fieldValue('bairro'),
                    localidade: _fieldValue('localidade'),
                    uf: _fieldValue('uf'),
                    ibge: int.parse(removeNonDigits(_fieldValue('ibge'))),
                    gia: _fieldValue('gia').isNotEmpty
                        ? int.parse(_fieldValue('gia'))
                        : null,
                    ddd: int.parse(removeNonDigits(_fieldValue('ddd'))),
                    siafi: int.parse(_fieldValue('siafi')),
                  );

                  if (formType == 'creation') {
                    viaCepService.createViaCep(viaCep);
                  } else {
                    viaCepService.updateViaCep(
                      viaCepId!,
                      viaCep,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
