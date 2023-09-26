import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/components/add_via_cep_screen_form_fields_widget.dart';

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
            AddViaCepScreenFormFielsdWidget(
              localidadeFieldController: _localidadeFieldController,
              logradouroFieldController: _logradouroFieldController,
              bairroFieldController: _bairroFieldController,
              complementoFieldController: _complementoFieldController,
              cepFieldController: _cepFieldController,
              ufFieldController: _ufFieldController,
              ibgeFieldController: _ibgeFieldController,
              giaFieldController: _giaFieldController,
              dddFieldController: _dddFieldController,
              siafiFieldController: _siafiFieldController,
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
