import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/via_cep_form_screen_fields_widget.dart';

import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class ViaCepFormWidget extends StatelessWidget {
  ViaCepFormWidget({
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
            ViaCepFormFielsdWidget(
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
