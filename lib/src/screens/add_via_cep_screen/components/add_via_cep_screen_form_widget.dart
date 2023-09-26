import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/utils/input_border_style.dart';

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
            FormField(
              fieldTitle: 'Localidade',
              hintText: 'São Paulo',
              fieldController: _localidadeFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Logradouro',
              hintText: 'Praça da Sé',
              fieldController: _logradouroFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Bairro',
              hintText: 'Sé',
              fieldController: _bairroFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Complemento',
              hintText: 'lado ímpar',
              fieldController: _complementoFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'CEP',
              hintText: '01001-000',
              fieldController: _cepFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'UF',
              hintText: 'SP',
              fieldController: _ufFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'IBGE',
              hintText: '3550308',
              fieldController: _ibgeFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'GIA',
              hintText: '1004',
              fieldController: _giaFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'DDD',
              hintText: '+11',
              fieldController: _dddFieldController,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Siafi',
              hintText: '7107',
              fieldController: _siafiFieldController,
            ),
          ],
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    super.key,
    required this.fieldTitle,
    required this.hintText,
    required this.fieldController,
  });

  final String fieldTitle;
  final String hintText;
  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$fieldTitle:',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2.0),
        TextFormField(
          controller: fieldController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 10.0,
            ),
            hintText: hintText,
            enabledBorder: inputBorderStyle(Colors.grey).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: inputBorderStyle(Colors.black).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedErrorBorder: inputBorderStyle(Colors.red).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorBorder: inputBorderStyle(Colors.red).copyWith(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }
}
