import 'package:flutter/material.dart';

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
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Logradouro',
          hintText: 'Praça da Sé',
          fieldController: logradouroFieldController,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Bairro',
          hintText: 'Sé',
          fieldController: bairroFieldController,
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
        ),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'UF',
          hintText: 'SP',
          fieldController: ufFieldController,
          maxLength: 2,
        ),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'IBGE',
          hintText: '3550308',
          fieldController: ibgeFieldController,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'GIA',
          hintText: '1004',
          fieldController: giaFieldController,
          isRequired: false,
        ),
        const SizedBox(height: 10.0),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'DDD',
          hintText: '+11',
          fieldController: dddFieldController,
          maxLength: 2,
        ),
        AddViaCepScreenFormFieldWidget(
          fieldTitle: 'Siafi',
          hintText: '7107',
          fieldController: siafiFieldController,
        ),
      ],
    );
  }
}
