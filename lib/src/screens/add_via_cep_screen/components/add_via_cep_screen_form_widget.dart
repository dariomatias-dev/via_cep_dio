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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Preencha o formulário',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            FormField(
              fieldTitle: 'Localidade',
              hintText: 'São Paulo',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Logradouro',
              hintText: 'Praça da Sé',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Bairro',
              hintText: 'Sé',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Complemento',
              hintText: 'lado ímpar',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'CEP',
              hintText: '01001-000',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'UF',
              hintText: 'SP',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'IBGE',
              hintText: '3550308',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'GIA',
              hintText: '1004',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'DDD',
              hintText: '+11',
            ),
            SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Siafi',
              hintText: '7107',
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
  });

  final String fieldTitle;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$fieldTitle:',
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2.0),
        TextFormField(
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
        ),
      ],
    );
  }
}
