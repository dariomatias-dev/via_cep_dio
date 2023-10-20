import 'package:cep_dio/src/utils/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/enums/enums.dart';
import 'package:cep_dio/src/core/helpers/regex_helper.dart';

import 'package:cep_dio/src/models/form_field_property_model.dart';
import 'package:cep_dio/src/models/cep_model.dart';

import 'package:cep_dio/src/screens/cep_form_screen/components/form_fields_properties_provider/auto_focus_and_submit_on_done.dart';
import 'package:cep_dio/src/screens/cep_form_screen/components/cep_form_screen_fields_widget.dart';

import 'package:cep_dio/src/services/cep_service.dart';

import 'package:cep_dio/src/widgets/default_button_widget.dart';

class CepFormWidget extends StatelessWidget {
  CepFormWidget({
    super.key,
    required this.screenContext,
    required this.formType,
    this.cepId,
    required this.formFieldsProperties,
  });

  final BuildContext screenContext;
  final FormTypesEnum formType;
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

  Future<bool> _existsCep(String cep) async {
    CepModel? data = await _cepService.getCep(cep);
    data ??= await _cepService.getCepByViaCep(cep);

    return data != null;
  }

  void _showDuplicateCEPAlertDialog() {
    const String title = 'CEP já existe';
    const String content =
        'O CEP que inseriu já existe.\nNão é possível cadastrar CEPs existentes.';
    const String actionTitle1 = 'Sair';
    const String actionTitle2 = 'OK';

    void action1() => _closeScreen();

    customAlertDialog(
      screenContext,
      title,
      content,
      actionTitle1,
      actionTitle2,
      action1,
      null,
    );
  }

  void _closeScreen() {
    Navigator.pop(screenContext);
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
              text: formType == FormTypesEnum.creation
                  ? 'ADICIONAR'
                  : 'ATUALIZAR',
              action: () async {
                _formKey.currentState!.validate();

                if (_validateForm()) {
                  final CepModel cep = CepModel(
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

                  if (formType == FormTypesEnum.creation) {
                    final bool isCepExists = await _existsCep(cep.cep);

                    if (isCepExists) {
                      _showDuplicateCEPAlertDialog();
                    } else {
                      _closeScreen();
                      _cepService.createCep(cep);
                    }
                  } else {
                    _closeScreen();
                    _cepService.updateCep(
                      cepId!,
                      cep,
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
