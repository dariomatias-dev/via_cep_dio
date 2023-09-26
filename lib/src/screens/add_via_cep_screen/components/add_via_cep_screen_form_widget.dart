import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/components/add_via_cep_screen_form_field_widget.dart';

import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class AddViaCepScreenFormWidget extends StatefulWidget {
  const AddViaCepScreenFormWidget({super.key});

  @override
  State<AddViaCepScreenFormWidget> createState() =>
      _AddViaCepScreenFormWidgetState();
}

class _AddViaCepScreenFormWidgetState extends State<AddViaCepScreenFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _localidadeFieldController =
      TextEditingController();
  final TextEditingController _logradouroFieldController =
      TextEditingController();
  final TextEditingController _bairroFieldController = TextEditingController();
  final TextEditingController _complementoFieldController =
      TextEditingController();
  final TextEditingController _cepFieldController = TextEditingController();
  final TextEditingController _ufFieldController = TextEditingController();
  final TextEditingController _ibgeFieldController = TextEditingController();
  final TextEditingController _giaFieldController = TextEditingController();
  final TextEditingController _dddFieldController = TextEditingController();
  final TextEditingController _siafiFieldController = TextEditingController();

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
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'Localidade',
              hintText: 'São Paulo',
              fieldController: _localidadeFieldController,
            ),
            const SizedBox(height: 10.0),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'Logradouro',
              hintText: 'Praça da Sé',
              fieldController: _logradouroFieldController,
            ),
            const SizedBox(height: 10.0),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'Bairro',
              hintText: 'Sé',
              fieldController: _bairroFieldController,
            ),
            const SizedBox(height: 10.0),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'Complemento',
              hintText: 'lado ímpar',
              fieldController: _complementoFieldController,
              isRequired: false,
            ),
            const SizedBox(height: 10.0),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'CEP',
              hintText: '01001-000',
              fieldController: _cepFieldController,
              maxLength: 9,
            ),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'UF',
              hintText: 'SP',
              fieldController: _ufFieldController,
              maxLength: 2,
            ),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'IBGE',
              hintText: '3550308',
              fieldController: _ibgeFieldController,
            ),
            const SizedBox(height: 10.0),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'GIA',
              hintText: '1004',
              fieldController: _giaFieldController,
              isRequired: false,
            ),
            const SizedBox(height: 10.0),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'DDD',
              hintText: '+11',
              fieldController: _dddFieldController,
              maxLength: 2,
            ),
            AddViaCepScreenFormFieldWidget(
              fieldTitle: 'Siafi',
              hintText: '7107',
              fieldController: _siafiFieldController,
            ),
            DefaultButtonWidget(
              text: 'Adicionar',
              action: () {
                if (_formKey.currentState!.validate()) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
