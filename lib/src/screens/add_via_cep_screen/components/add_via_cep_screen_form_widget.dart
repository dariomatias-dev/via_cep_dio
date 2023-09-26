import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/components/add_via_cep_screen_form_fields_widget.dart';

import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class AddViaCepScreenFormWidget extends StatefulWidget {
  const AddViaCepScreenFormWidget({
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
  State<AddViaCepScreenFormWidget> createState() =>
      _AddViaCepScreenFormWidgetState();
}

class _AddViaCepScreenFormWidgetState extends State<AddViaCepScreenFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              localidadeFieldController: widget.localidadeFieldController,
              logradouroFieldController: widget.logradouroFieldController,
              bairroFieldController: widget.bairroFieldController,
              complementoFieldController: widget.complementoFieldController,
              cepFieldController: widget.cepFieldController,
              ufFieldController: widget.ufFieldController,
              ibgeFieldController: widget.ibgeFieldController,
              giaFieldController: widget.giaFieldController,
              dddFieldController: widget.dddFieldController,
              siafiFieldController: widget.siafiFieldController,
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
