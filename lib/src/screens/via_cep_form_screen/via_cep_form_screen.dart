import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/via_cep_form_widget.dart';

import 'package:via_cep_dio/src/widgets/back_button_widget.dart';

class ViaCepFormScreen extends StatefulWidget {
  const ViaCepFormScreen({super.key});

  @override
  State<ViaCepFormScreen> createState() => _ViaCepFormScreenState();
}

class _ViaCepFormScreenState extends State<ViaCepFormScreen> {
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

  bool _hasValuesInFields() {
    final List<TextEditingController> fieldControllers = [
      _localidadeFieldController,
      _logradouroFieldController,
      _bairroFieldController,
      _complementoFieldController,
      _cepFieldController,
      _ufFieldController,
      _ibgeFieldController,
      _giaFieldController,
      _dddFieldController,
      _siafiFieldController,
    ];

    return fieldControllers.any((fieldController) {
      return fieldController.text.trim().isNotEmpty;
    });
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: const Text('Deseja mesmo sair?'),
          content: const Text(
            'Se sair da tela todos os dados do formulário serão perdidos, não será possível recuperá-los.',
            textAlign: TextAlign.justify,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(alertDialogContext);
                Navigator.pop(context);
              },
              child: const Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(alertDialogContext);
              },
              child: const Text('Não'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _localidadeFieldController.dispose();
    _logradouroFieldController.dispose();
    _bairroFieldController.dispose();
    _complementoFieldController.dispose();
    _cepFieldController.dispose();
    _ufFieldController.dispose();
    _ibgeFieldController.dispose();
    _giaFieldController.dispose();
    _dddFieldController.dispose();
    _siafiFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Adicionar CEP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: BackButtonWidget(
          action: () {
            if (_hasValuesInFields()) {
              _showAlertDialog(context);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ViaCepFormWidget(
          screenContext: context,
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
      ),
    );
  }
}
