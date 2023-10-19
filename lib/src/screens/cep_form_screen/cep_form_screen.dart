import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/helpers/number_format_brazil_helper.dart';

import 'package:cep_dio/src/models/cep_model.dart';

import 'package:cep_dio/src/screens/cep_form_screen/components/form_fields_properties_provider/form_fields_properties_provider.dart';
import 'package:cep_dio/src/screens/cep_form_screen/components/cep_form_widget.dart';

import 'package:cep_dio/src/services/cep_service.dart';

import 'package:cep_dio/src/widgets/back_button_widget.dart';

class CepFormScreen extends StatefulWidget {
  const CepFormScreen({
    super.key,
    required this.formType,
    this.cepId,
  });

  final String formType;
  final String? cepId;

  @override
  State<CepFormScreen> createState() => _CepFormScreenState();
}

class _CepFormScreenState extends State<CepFormScreen> {
  final CepService _cepService = CepService();

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

  List<TextEditingController> get _fieldControllers => [
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

  FormFieldsPropertiesProvider get _formFieldsPropertiesInstance =>
      FormFieldsPropertiesProvider(
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
      );

  bool _hasValuesInFields() {
    return _fieldControllers.any((fieldController) {
      return fieldController.text.trim().isNotEmpty;
    });
  }

  void _leaveConfirmationDialog() {
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

  void _dataFetchErrorDialog() {
    showDialog(
      context: context,
      builder: (alertDialogContext) => AlertDialog(
        title: const Text('Ocorreu um problema'),
        content: const Text(
          'Não foi possível buscar os dados do CEP.\nPor favor, tente novamente ou volte mais tarde.',
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(alertDialogContext);
              Navigator.pop(context);
            },
            child: const Text('Sair'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(alertDialogContext);
              _fetchData();
            },
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchData() async {
    final CepModel? cep = await _cepService.getCep(widget.cepId!);

    if (cep == null) {
      _dataFetchErrorDialog();
    } else {
      final CepModel(
        :localidade,
        :logradouro,
        :bairro,
        :complemento,
        :uf,
        :ibge,
        :gia,
        :ddd,
        :siafi,
      ) = cep;

      _localidadeFieldController.text = localidade;
      _logradouroFieldController.text = logradouro;
      _bairroFieldController.text = bairro;
      _complementoFieldController.text = complemento ?? '';
      _cepFieldController.text = cep.cep;
      _ufFieldController.text = uf;
      _ibgeFieldController.text = numberFormatBrazilHelper(ibge);
      _giaFieldController.text = gia != null ? gia.toString() : '';
      _dddFieldController.text = '+$ddd';
      _siafiFieldController.text = siafi.toString();
    }
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

    _formFieldsPropertiesInstance.disposeFocusNodes();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.formType == 'creation' ? 'Adicionar CEP' : 'Atualizar CEP',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: BackButtonWidget(
          action: () {
            if (_hasValuesInFields()) {
              _leaveConfirmationDialog();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: FutureBuilder(
        future: widget.formType == 'update' ? _fetchData() : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: CepFormWidget(
              screenContext: context,
              formType: widget.formType,
              cepId: widget.cepId,
              formFieldsProperties: _formFieldsPropertiesInstance.get(),
            ),
          );
        },
      ),
    );
  }
}
