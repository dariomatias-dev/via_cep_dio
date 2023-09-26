import 'package:flutter/material.dart';
import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

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
              isRequired: true,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Logradouro',
              hintText: 'Praça da Sé',
              fieldController: _logradouroFieldController,
              isRequired: true,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Bairro',
              hintText: 'Sé',
              fieldController: _bairroFieldController,
              isRequired: true,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Complemento',
              hintText: 'lado ímpar',
              fieldController: _complementoFieldController,
              isRequired: false,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'CEP',
              hintText: '01001-000',
              fieldController: _cepFieldController,
              isRequired: true,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'UF',
              hintText: 'SP',
              fieldController: _ufFieldController,
              isRequired: true,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'IBGE',
              hintText: '3550308',
              fieldController: _ibgeFieldController,
              isRequired: true,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'GIA',
              hintText: '1004',
              fieldController: _giaFieldController,
              isRequired: false,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'DDD',
              hintText: '+11',
              fieldController: _dddFieldController,
              isRequired: true,
            ),
            const SizedBox(height: 10.0),
            FormField(
              fieldTitle: 'Siafi',
              hintText: '7107',
              fieldController: _siafiFieldController,
              isRequired: true,
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

class FormField extends StatelessWidget {
  const FormField({
    super.key,
    required this.fieldTitle,
    required this.hintText,
    required this.fieldController,
    required this.isRequired,
  });

  final String fieldTitle;
  final String hintText;
  final TextEditingController fieldController;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$fieldTitle:',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red.shade400,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 2.0),
        TextFormField(
          controller: fieldController,
          validator: (value) {
            if (value == null || (isRequired && value.isEmpty)) {
              return 'Insirá algum valor';
            }

            return null;
          },
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
