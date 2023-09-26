import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/components/add_via_cep_screen_form_fields_widget.dart';

import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class AddViaCepScreenFormWidget extends StatelessWidget {
  AddViaCepScreenFormWidget({
    super.key,
    required this.screenContext,
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

  final BuildContext screenContext;

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
              localidadeFieldController: localidadeFieldController,
              logradouroFieldController: logradouroFieldController,
              bairroFieldController: bairroFieldController,
              complementoFieldController: complementoFieldController,
              cepFieldController: cepFieldController,
              ufFieldController: ufFieldController,
              ibgeFieldController: ibgeFieldController,
              giaFieldController: giaFieldController,
              dddFieldController: dddFieldController,
              siafiFieldController: siafiFieldController,
            ),
            DefaultButtonWidget(
              text: 'ADICIONAR',
              action: () {
                if (_formKey.currentState!.validate()) {
                  //Navigator.pop(widget.screenContext);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
