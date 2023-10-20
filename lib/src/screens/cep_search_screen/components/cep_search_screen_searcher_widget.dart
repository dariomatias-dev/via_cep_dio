import 'package:cep_dio/src/screens/cep_search_screen/components/cep_card_details_widget.dart';
import 'package:cep_dio/src/utils/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:cep_dio/src/models/cep_model.dart';

import 'package:cep_dio/src/services/cep_service.dart';

class CepSearchScreenSearcherWidget extends StatefulWidget {
  const CepSearchScreenSearcherWidget({
    super.key,
    required this.cepToSearch,
  });

  final String? cepToSearch;

  @override
  State<CepSearchScreenSearcherWidget> createState() =>
      _CepSearchScreenSearcherWidgetState();
}

class _CepSearchScreenSearcherWidgetState
    extends State<CepSearchScreenSearcherWidget> {
  final CepService _cepService = CepService();
  CepModel? _cep;

  void _createCEPConfirmationDialog() {
    const String title = 'Criar CEP';
    const String content = 'Esse CEP ainda não existe.\nDeseja criá-lo?';
    const String actionTitle1 = 'Não';
    const String actionTitle2 = 'Sim';
    void action1() {}
    void action2() {}

    customAlertDialog(
      context,
      title,
      content,
      actionTitle1,
      actionTitle2,
      action1,
      action2,
    );
  }

  Future<void> _fetchData() async {
    CepModel? cep = await _cepService.getCepByViaCep(widget.cepToSearch!);
    cep ??= await _cepService.getCep(widget.cepToSearch!);

    if (cep == null) {
      _createCEPConfirmationDialog();
    } else {
      _cep = cep;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.cepToSearch != null
        ? FutureBuilder(
            future: _fetchData(),
            builder: (context, snapshot) {
              final verifcationsResult = verificationsHelper(
                snapshot.connectionState,
                snapshot.hasError,
              );

              if (verifcationsResult != null) {
                return verifcationsResult;
              }

              return _cep != null
                  ? CepCardDetailsWidget(
                      cep: _cep!,
                    )
                  : Container();
            },
          )
        : Container();
  }
}
