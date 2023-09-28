import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/core/helpers/masks_helper.dart';
import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/form_fields_properties_provider/handle_ibge_field_change.dart';
import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/form_fields_properties_provider/handle_uf_field_change.dart';

class FormFieldsPropertiesProvider {
  FilteringTextInputFormatter get _lettersOnlyFormatter =>
      FilteringTextInputFormatter.allow(
        RegexHelper.alphabeticAndAccentPattern,
      );

  FilteringTextInputFormatter get _filterNumeric =>
      FilteringTextInputFormatter.deny(
        RegexHelper.hyphenAndDot,
      );

  List<FormFieldPropertyModel> get(
    final TextEditingController localidadeFieldController,
    final TextEditingController logradouroFieldController,
    final TextEditingController bairroFieldController,
    final TextEditingController complementoFieldController,
    final TextEditingController cepFieldController,
    final TextEditingController ufFieldController,
    final TextEditingController ibgeFieldController,
    final TextEditingController giaFieldController,
    final TextEditingController dddFieldController,
    final TextEditingController siafiFieldController,
  ) {
    return [
      FormFieldPropertyModel(
        fieldTitle: 'Localidade',
        hintText: 'São Paulo',
        fieldController: localidadeFieldController,
        inputFormatter: _lettersOnlyFormatter,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Logradouro',
        hintText: 'Praça da Sé',
        fieldController: logradouroFieldController,
        inputFormatter: _lettersOnlyFormatter,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Bairro',
        hintText: 'Sé',
        fieldController: bairroFieldController,
        inputFormatter: _lettersOnlyFormatter,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Complemento',
        hintText: 'lado ímpar',
        fieldController: complementoFieldController,
        isRequired: false,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'CEP',
        hintText: '01001-000',
        fieldController: cepFieldController,
        maxLength: 9,
        mask: masksHelper.cep,
        keyboardType: TextInputType.number,
        validation: (String? value) => value != null ? value.length < 9 : false,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'UF',
        hintText: 'SP',
        fieldController: ufFieldController,
        maxLength: 2,
        onChanged: (_) => handleUfFieldChange(ufFieldController),
        inputFormatter: _lettersOnlyFormatter,
        validation: (String? value) => value != null ? value.length < 2 : false,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'IBGE',
        hintText: '3.550.308',
        fieldController: ibgeFieldController,
        maxLength: 9,
        keyboardType: TextInputType.number,
        onChanged: (_) => handleIbgeFieldChange(ibgeFieldController),
      ),
      FormFieldPropertyModel(
        fieldTitle: 'GIA',
        hintText: '1004',
        fieldController: giaFieldController,
        isRequired: false,
        keyboardType: TextInputType.number,
        inputFormatter: _filterNumeric,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'DDD',
        hintText: '+11',
        fieldController: dddFieldController,
        maxLength: 3,
        mask: masksHelper.ddd,
        keyboardType: TextInputType.number,
        validation: (String? value) => value != null ? value.length < 3 : false,
      ),
      FormFieldPropertyModel(
        fieldTitle: 'Siafi',
        hintText: '7107',
        fieldController: siafiFieldController,
        keyboardType: TextInputType.number,
        inputFormatter: _filterNumeric,
      ),
    ];
  }
}
