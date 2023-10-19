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
    showDialog(
      context: context,
      builder: (alertDialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            36.0,
          ),
        ),
        backgroundColor: Colors.black,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        content: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8.0),
                Container(
                  height: 4.0,
                  width: 32.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Criar CEP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 28.0),
                Text(
                  'Esse CEP ainda não existe.\nDeseja criá-lo?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey.shade200,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 28.0),
                Row(
                  children: [
                    AlertDialogAction(
                      action: () {
                        Navigator.pop(alertDialogContext);
                      },
                      title: 'Não',
                      color: Colors.blueGrey.shade800.withOpacity(0.6),
                    ),
                    const SizedBox(width: 8.0),
                    AlertDialogAction(
                      action: () {
                        Navigator.pop(alertDialogContext);
                      },
                      title: 'Sim',
                      color: Colors.yellow.shade700,
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Container(
                  height: 3.0,
                  width: 120.0,
                  margin: const EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                  ? Text(_cep?.cep ?? 'Nao foi dessa vez')
                  : Container();
            },
          )
        : Container();
  }
}

class AlertDialogAction extends StatelessWidget {
  const AlertDialogAction({
    super.key,
    required this.action,
    required this.title,
    required this.color,
  });

  final void Function() action;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
