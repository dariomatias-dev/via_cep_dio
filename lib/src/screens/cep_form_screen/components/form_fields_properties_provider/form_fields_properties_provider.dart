import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/core/helpers/masks_helper.dart';
import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

import 'package:via_cep_dio/src/screens/cep_form_screen/components/form_fields_properties_provider/auto_focus_and_submit_on_done.dart';
import 'package:via_cep_dio/src/screens/cep_form_screen/components/form_fields_properties_provider/handle_ibge_field_change.dart';
import 'package:via_cep_dio/src/screens/cep_form_screen/components/form_fields_properties_provider/handle_uf_field_change.dart';

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

  final FocusNode _cepFocusNode = FocusNode();
  final FocusNode _logradouroFocusNode = FocusNode();
  final FocusNode _complementoFocusNode = FocusNode();
  final FocusNode _bairroFocusNode = FocusNode();
  final FocusNode _localidadeFocusNode = FocusNode();
  final FocusNode _ufFocusNode = FocusNode();
  final FocusNode _ibgeFocusNode = FocusNode();
  final FocusNode _giaFocusNode = FocusNode();
  final FocusNode _dddFocusNode = FocusNode();
  final FocusNode _siafiFocusNode = FocusNode();

  FilteringTextInputFormatter get _lettersOnlyFormatter =>
      FilteringTextInputFormatter.allow(
        RegexHelper.alphabeticAndAccentPattern,
      );

  FilteringTextInputFormatter get _filterNumeric =>
      FilteringTextInputFormatter.deny(
        RegexHelper.hyphenAndDot,
      );

  void _handleOnDone(
    String fieldTitle,
    List<FormFieldPropertyModel> getFormFieldProperties,
  ) =>
      autoFocusOnDone(
        fieldTitle,
        getFormFieldProperties,
      );

  List<FormFieldPropertyModel> get() {
    return [
      FormFieldPropertyModel(
        fieldTitle: 'Localidade',
        hintText: 'São Paulo',
        fieldController: localidadeFieldController,
        minLenght: 3,
        inputFormatter: _lettersOnlyFormatter,
        inputFocusNode: _localidadeFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Logradouro',
        hintText: 'Praça da Sé',
        fieldController: logradouroFieldController,
        minLenght: 3,
        inputFormatter: _lettersOnlyFormatter,
        inputFocusNode: _logradouroFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Bairro',
        hintText: 'Sé',
        fieldController: bairroFieldController,
        minLenght: 2,
        inputFormatter: _lettersOnlyFormatter,
        inputFocusNode: _bairroFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Complemento',
        hintText: 'lado ímpar',
        fieldController: complementoFieldController,
        isRequired: false,
        inputFocusNode: _complementoFocusNode,
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
        inputFocusNode: _cepFocusNode,
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
        inputFocusNode: _ufFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'IBGE',
        hintText: '3.550.308',
        fieldController: ibgeFieldController,
        minLenght: 2,
        maxLength: 9,
        keyboardType: TextInputType.number,
        onChanged: (_) => handleIbgeFieldChange(ibgeFieldController),
        inputFocusNode: _ibgeFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'GIA',
        hintText: '1004',
        fieldController: giaFieldController,
        isRequired: false,
        keyboardType: TextInputType.number,
        inputFormatter: _filterNumeric,
        inputFocusNode: _giaFocusNode,
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
        inputFocusNode: _dddFocusNode,
        handleOnDone: _handleOnDone,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Siafi',
        hintText: '7107',
        fieldController: siafiFieldController,
        keyboardType: TextInputType.number,
        inputFormatter: _filterNumeric,
        inputFocusNode: _siafiFocusNode,
        handleOnDone: _handleOnDone,
      ),
    ];
  }

  void disposeFocusNodes() {
    _cepFocusNode.dispose();
    _logradouroFocusNode.dispose();
    _complementoFocusNode.dispose();
    _bairroFocusNode.dispose();
    _localidadeFocusNode.dispose();
    _ufFocusNode.dispose();
    _ibgeFocusNode.dispose();
    _giaFocusNode.dispose();
    _dddFocusNode.dispose();
    _siafiFocusNode.dispose();
  }
}
