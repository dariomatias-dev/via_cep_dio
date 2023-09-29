import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/core/helpers/masks_helper.dart';
import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/form_fields_properties_provider/auto_focus_and_submit_on_done.dart';
import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/form_fields_properties_provider/handle_ibge_field_change.dart';
import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/form_fields_properties_provider/handle_uf_field_change.dart';

class FormFieldsPropertiesProvider {
  FormFieldsPropertiesProvider({
    required this.localidadeFieldController,
    required this.logradouroFieldController,
    required this.bairroFieldController,
    required this.complementoFieldController,
    required this.cepFieldController,
    required this.ufFieldController,
    required this.ibgeFieldController,
    required this.giaFieldController,
    required this.dddFieldController,
    required this.siafiFieldController,
  });

  final TextEditingController localidadeFieldController;
  final TextEditingController logradouroFieldController;
  final TextEditingController bairroFieldController;
  final TextEditingController complementoFieldController;
  final TextEditingController cepFieldController;
  final TextEditingController ufFieldController;
  final TextEditingController ibgeFieldController;
  final TextEditingController giaFieldController;
  final TextEditingController dddFieldController;
  final TextEditingController siafiFieldController;

  final FocusNode cepFocusNode = FocusNode();
  final FocusNode logradouroFocusNode = FocusNode();
  final FocusNode complementoFocusNode = FocusNode();
  final FocusNode bairroFocusNode = FocusNode();
  final FocusNode localidadeFocusNode = FocusNode();
  final FocusNode ufFocusNode = FocusNode();
  final FocusNode ibgeFocusNode = FocusNode();
  final FocusNode giaFocusNode = FocusNode();
  final FocusNode dddFocusNode = FocusNode();
  final FocusNode siafiFocusNode = FocusNode();

  FilteringTextInputFormatter get _lettersOnlyFormatter =>
      FilteringTextInputFormatter.allow(
        RegexHelper.alphabeticAndAccentPattern,
      );

  FilteringTextInputFormatter get _filterNumeric =>
      FilteringTextInputFormatter.deny(
        RegexHelper.hyphenAndDot,
      );

  String? _validateValue(
    String fieldTitle,
    bool isRequired,
    String? value,
    int? exactCharacterCount,
  ) {
    if (value == null || (isRequired && value.trim().isEmpty)) {
      return 'Insira um valor';
    } else if ((exactCharacterCount != null
        ? (value.trim()).length < exactCharacterCount
        : false)) {
      return 'Insira um $fieldTitle válido';
    }

    return null;
  }

  void _handleOnDone(String fieldTitle) => autoFocusOnDone(fieldTitle, get());

  List<FormFieldPropertyModel> get() {
    return [
      FormFieldPropertyModel(
        fieldTitle: 'Localidade',
        hintText: 'São Paulo',
        fieldController: localidadeFieldController,
        inputFormatter: _lettersOnlyFormatter,
        validateValue: _validateValue,
        inputFocusNode: localidadeFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Logradouro',
        hintText: 'Praça da Sé',
        fieldController: logradouroFieldController,
        inputFormatter: _lettersOnlyFormatter,
        validateValue: _validateValue,
        inputFocusNode: logradouroFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Bairro',
        hintText: 'Sé',
        fieldController: bairroFieldController,
        inputFormatter: _lettersOnlyFormatter,
        validateValue: _validateValue,
        inputFocusNode: bairroFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Complemento',
        hintText: 'lado ímpar',
        fieldController: complementoFieldController,
        isRequired: false,
        validateValue: _validateValue,
        inputFocusNode: complementoFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'CEP',
        hintText: '01001-000',
        fieldController: cepFieldController,
        maxLength: 9,
        mask: masksHelper.cep,
        keyboardType: TextInputType.number,
        exactCharacterCount: 9,
        validateValue: _validateValue,
        inputFocusNode: cepFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'UF',
        hintText: 'SP',
        fieldController: ufFieldController,
        maxLength: 2,
        onChanged: (_) => handleUfFieldChange(ufFieldController),
        inputFormatter: _lettersOnlyFormatter,
        exactCharacterCount: 2,
        validateValue: _validateValue,
        inputFocusNode: ufFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'IBGE',
        hintText: '3.550.308',
        fieldController: ibgeFieldController,
        maxLength: 9,
        keyboardType: TextInputType.number,
        onChanged: (_) => handleIbgeFieldChange(ibgeFieldController),
        validateValue: _validateValue,
        inputFocusNode: ibgeFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'GIA',
        hintText: '1004',
        fieldController: giaFieldController,
        isRequired: false,
        keyboardType: TextInputType.number,
        inputFormatter: _filterNumeric,
        validateValue: _validateValue,
        inputFocusNode: giaFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'DDD',
        hintText: '+11',
        fieldController: dddFieldController,
        maxLength: 3,
        mask: masksHelper.ddd,
        keyboardType: TextInputType.number,
        exactCharacterCount: 3,
        validateValue: _validateValue,
        inputFocusNode: dddFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Siafi',
        hintText: '7107',
        fieldController: siafiFieldController,
        keyboardType: TextInputType.number,
        inputFormatter: _filterNumeric,
        validateValue: _validateValue,
        inputFocusNode: siafiFocusNode,
        handleOnDone: _handleOnDone,
      ),
    ];
  }

  void disposeFocusNodes() {
    cepFocusNode.dispose();
    logradouroFocusNode.dispose();
    complementoFocusNode.dispose();
    bairroFocusNode.dispose();
    localidadeFocusNode.dispose();
    ufFocusNode.dispose();
    ibgeFocusNode.dispose();
    giaFocusNode.dispose();
    dddFocusNode.dispose();
    siafiFocusNode.dispose();
  }
}