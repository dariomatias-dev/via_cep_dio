import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/core/helpers/masks_helper.dart';
import 'package:via_cep_dio/src/core/helpers/number_format_brazil_helper.dart';
import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/via_cep_form_screen_field_widget.dart';

class ViaCepFormFielsdWidget extends StatelessWidget {
  const ViaCepFormFielsdWidget({
    super.key,
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

  FilteringTextInputFormatter get _lettersOnlyFormatter =>
      FilteringTextInputFormatter.allow(
        RegexHelper.alphabeticAndAccentPattern,
      );

  FilteringTextInputFormatter get _filterNumeric =>
      FilteringTextInputFormatter.deny(
        RegexHelper.hyphenAndDot,
      );

  void _handleUfFieldChange() {
    final value = ufFieldController.text;
    final formattedValue = value.toUpperCase();
    ufFieldController.value = ufFieldController.value.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(
        offset: formattedValue.length,
      ),
    );
  }

  void _handleIbgeFieldChange() {
    final String ibgeFieldValue = ibgeFieldController.text.replaceAll(
      RegexHelper.nonDigit,
      '',
    );
    final value = ibgeFieldValue.isNotEmpty ? int.parse(ibgeFieldValue) : 0;
    final formattedValue = value != 0 ? numberFormatBrazilHelper(value) : '';

    ibgeFieldController.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(
        offset: formattedValue.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ViaCepFormFieldWidget(
          fieldTitle: 'Localidade',
          hintText: 'São Paulo',
          fieldController: localidadeFieldController,
          inputFormatter: _lettersOnlyFormatter,
        ),
        const SizedBox(height: 10.0),
        ViaCepFormFieldWidget(
          fieldTitle: 'Logradouro',
          hintText: 'Praça da Sé',
          fieldController: logradouroFieldController,
          inputFormatter: _lettersOnlyFormatter,
        ),
        const SizedBox(height: 10.0),
        ViaCepFormFieldWidget(
          fieldTitle: 'Bairro',
          hintText: 'Sé',
          fieldController: bairroFieldController,
          inputFormatter: _lettersOnlyFormatter,
        ),
        const SizedBox(height: 10.0),
        ViaCepFormFieldWidget(
          fieldTitle: 'Complemento',
          hintText: 'lado ímpar',
          fieldController: complementoFieldController,
          isRequired: false,
        ),
        const SizedBox(height: 10.0),
        ViaCepFormFieldWidget(
          fieldTitle: 'CEP',
          hintText: '01001-000',
          fieldController: cepFieldController,
          maxLength: 9,
          mask: masksHelper.cep,
          keyboardType: TextInputType.number,
          validation: (String? value) =>
              value != null ? value.length < 9 : false,
        ),
        ViaCepFormFieldWidget(
          fieldTitle: 'UF',
          hintText: 'SP',
          fieldController: ufFieldController,
          maxLength: 2,
          onChanged: (_) => _handleUfFieldChange(),
          inputFormatter: _lettersOnlyFormatter,
          validation: (String? value) =>
              value != null ? value.length < 2 : false,
        ),
        ViaCepFormFieldWidget(
          fieldTitle: 'IBGE',
          hintText: '3.550.308',
          fieldController: ibgeFieldController,
          maxLength: 9,
          keyboardType: TextInputType.number,
          onChanged: (_) => _handleIbgeFieldChange(),
        ),
        ViaCepFormFieldWidget(
          fieldTitle: 'GIA',
          hintText: '1004',
          fieldController: giaFieldController,
          isRequired: false,
          keyboardType: TextInputType.number,
          inputFormatter: _filterNumeric,
        ),
        const SizedBox(height: 10.0),
        ViaCepFormFieldWidget(
          fieldTitle: 'DDD',
          hintText: '+11',
          fieldController: dddFieldController,
          maxLength: 3,
          mask: masksHelper.ddd,
          keyboardType: TextInputType.number,
          validation: (String? value) =>
              value != null ? value.length < 3 : false,
        ),
        ViaCepFormFieldWidget(
          fieldTitle: 'Siafi',
          hintText: '7107',
          fieldController: siafiFieldController,
          keyboardType: TextInputType.number,
          inputFormatter: _filterNumeric,
        ),
      ],
    );
  }
}
