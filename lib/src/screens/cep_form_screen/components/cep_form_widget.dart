import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';
import 'package:via_cep_dio/src/models/cep_model.dart';

import 'package:via_cep_dio/src/screens/cep_form_screen/components/form_fields_properties_provider/auto_focus_and_submit_on_done.dart';
import 'package:via_cep_dio/src/screens/cep_form_screen/components/cep_form_screen_fields_widget.dart';

import 'package:via_cep_dio/src/services/cep_service.dart';

import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class 
CepFormWidget extends StatelessWidget {
  
  CepFormWidget({
    super.key,
    required this.screenContext,
    required this.formType,
    this.cepId,
    required this.formFieldsProperties,
  });

  final BuildContext screenContext;
  final String formType;
  final String? cepId;
  final List<FormFieldPropertyModel> formFieldsProperties;

  final CepService _cepService = CepService();

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

  String _removeNonDigits(String input) {
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
            CepFormFielsdWidget(
              formFieldsProperties: formFieldsProperties,
            ),
            DefaultButtonWidget(
              text: formType == 'creation' ? 'ADICIONAR' : 'ATUALIZAR',
              action: () {
                _formKey.currentState!.validate();

                if (_validateForm()) {
                  Navigator.pop(screenContext);

                  final CepModel viaCep = CepModel(
                    cep: _fieldValue('cep'),
                    logradouro: _fieldValue('logradouro'),
                    complemento: _fieldValue('complemento'),
                    bairro: _fieldValue('bairro'),
                    localidade: _fieldValue('localidade'),
                    uf: _fieldValue('uf'),
                    ibge: int.parse(_removeNonDigits(_fieldValue('ibge'))),
                    gia: _fieldValue('gia').isNotEmpty
                        ? int.parse(_fieldValue('gia'))
                        : null,
                    ddd: int.parse(_removeNonDigits(_fieldValue('ddd'))),
                    siafi: int.parse(_fieldValue('siafi')),
                  );

                  if (formType == 'creation') {
                    _cepService.createCep(viaCep);
                  } else {
                    _cepService.updateCep(
                      cepId!,
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
