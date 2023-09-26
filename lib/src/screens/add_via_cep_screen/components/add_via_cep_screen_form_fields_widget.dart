import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:via_cep_dio/src/core/helpers/masks_helper.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/components/add_via_cep_screen_form_field_widget.dart';

class AddViaCepScreenFormFielsdWidget extends StatelessWidget {
  const AddViaCepScreenFormFielsdWidget({
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
        RegExp(r'[a-zA-Z]'),
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
    final NumberFormat numberFormat = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: 0,
    );
    final String ibgeFieldValue = ibgeFieldController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final value = ibgeFieldValue.isNotEmpty ? int.parse(ibgeFieldValue) : 0;
    final formattedValue = value != 0 ? numberFormat.format(value) : '';

    ibgeFieldController.value = ibgeFieldController.value.copyWith(
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
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Localidade',
          hintText: 'São Paulo',
          fieldController: localidadeFieldController,
          inputFormatter: _lettersOnlyFormatter,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Logradouro',
          hintText: 'Praça da Sé',
          fieldController: logradouroFieldController,
          inputFormatter: _lettersOnlyFormatter,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Bairro',
          hintText: 'Sé',
          fieldController: bairroFieldController,
          inputFormatter: _lettersOnlyFormatter,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Complemento',
          hintText: 'lado ímpar',
          fieldController: complementoFieldController,
          isRequired: false,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'CEP',
          hintText: '01001-000',
          fieldController: cepFieldController,
          maxLength: 9,
          mask: masksHelper.cep,
          keyboardType: TextInputType.number,
        ),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'UF',
          hintText: 'SP',
          fieldController: ufFieldController,
          maxLength: 2,
          onChanged: (_) => _handleUfFieldChange(),
          inputFormatter: _lettersOnlyFormatter,
        ),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'IBGE',
          hintText: '3.550.308',
          fieldController: ibgeFieldController,
          maxLength: 10,
          keyboardType: TextInputType.number,
          onChanged: (_) => _handleIbgeFieldChange(),
        ),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'GIA',
          hintText: '1004',
          fieldController: giaFieldController,
          isRequired: false,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'DDD',
          hintText: '+11',
          fieldController: dddFieldController,
          maxLength: 3,
          mask: masksHelper.ddd,
          keyboardType: TextInputType.number,
        ),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Siafi',
          hintText: '7107',
          fieldController: siafiFieldController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
