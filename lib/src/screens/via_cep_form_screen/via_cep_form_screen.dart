import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/number_format_brazil_helper.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';
import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/form_fields_properties_provider/form_fields_properties_provider.dart';
import 'package:via_cep_dio/src/screens/via_cep_form_screen/components/via_cep_form_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

import 'package:via_cep_dio/src/widgets/back_button_widget.dart';

class ViaCepFormScreen extends StatefulWidget {
  const ViaCepFormScreen({
    super.key,
    required this.formType,
    this.viaCepId,
  });

  final String formType;
  final String? viaCepId;

  @override
  State<ViaCepFormScreen> createState() => _ViaCepFormScreenState();
}

class _ViaCepFormScreenState extends State<ViaCepFormScreen> {
  final ViaCepService _viaCepService = ViaCepService();
  final FormFieldsPropertiesProvider _formFieldsPropertiesProvider =
      FormFieldsPropertiesProvider();

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

  List<TextEditingController> get fieldControllers => [
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

  List<FormFieldPropertyModel> _formFieldsProperties() {
    return _formFieldsPropertiesProvider.get(
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
    );
  }

  bool _hasValuesInFields() {
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

  Future<void> _fetchData() async {
    final ViaCepModel(
      :localidade,
      :logradouro,
      :bairro,
      :complemento,
      :cep,
      :uf,
      :ibge,
      :gia,
      :ddd,
      :siafi,
    ) = await _viaCepService.getViaCep(widget.viaCepId!);

    _localidadeFieldController.text = localidade;
    _logradouroFieldController.text = logradouro;
    _bairroFieldController.text = bairro;
    _complementoFieldController.text = complemento ?? '';
    _cepFieldController.text = cep;
    _ufFieldController.text = uf;
    _ibgeFieldController.text = numberFormatBrazilHelper(ibge);
    _giaFieldController.text = gia != null ? gia.toString() : '';
    _dddFieldController.text = '+$ddd';
    _siafiFieldController.text = siafi.toString();
  }

  @override
  void initState() {
    if (widget.formType == 'update') {
      _fetchData();
    }
    super.initState();
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

    _formFieldsPropertiesProvider.disposeFocusNodes();

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
          formType: widget.formType,
          viaCepId: widget.viaCepId,
          formFieldsProperties: _formFieldsProperties(),
        ),
      ),
    );
  }
}
