import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/via_cep_form_screen_fields_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class ViaCepFormWidget extends StatelessWidget {
  ViaCepFormWidget({
    super.key,
    required this.screenContext,
    required this.formType,
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

  final ViaCepService viaCepService = ViaCepService();

  final BuildContext screenContext;
  final String formType;

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

  String removeNonDigits(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

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
              text: formType == 'creation' ? 'ADICIONAR' : 'ATUALIZAR',
              action: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(screenContext);

                  final ViaCepModel viaCep = ViaCepModel(
                    cep: cepFieldController.text,
                    logradouro: logradouroFieldController.text,
                    complemento: complementoFieldController.text,
                    bairro: bairroFieldController.text,
                    localidade: localidadeFieldController.text,
                    uf: ufFieldController.text,
                    ibge: int.parse(removeNonDigits(ibgeFieldController.text)),
                    gia: giaFieldController.text.isNotEmpty ? int.parse(giaFieldController.text) : null,
                    ddd: int.parse(removeNonDigits(dddFieldController.text)),
                    siafi: int.parse(siafiFieldController.text),
                  );

                  if (formType == 'creation') {
                    viaCepService.createViaCep(viaCep);
                  } else {}
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
