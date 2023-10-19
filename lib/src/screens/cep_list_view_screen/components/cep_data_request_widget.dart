import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:cep_dio/src/models/cep_collection_model.dart';

import 'package:cep_dio/src/notifiers/cep_service_notifier.dart';

import 'package:cep_dio/src/providers/main_screen_inherited_widget.dart';

import 'package:cep_dio/src/screens/cep_list_view_screen/components/cep_list_view_widget.dart';

import 'package:cep_dio/src/services/cep_service.dart';

class CepDataRequestWidget extends StatefulWidget {
  const CepDataRequestWidget({super.key});

  @override
  State<CepDataRequestWidget> createState() => _CepDataRequestWidgetState();
}

class _CepDataRequestWidgetState extends State<CepDataRequestWidget> {
  final CepService cepService = CepService();

  int _skip = 0;
  int _limit = 0;
  CepCollectionModel? _cepCollection;
  bool requestsEnabled = false;

  Future<void> _updateSkip(
    int value,
  ) async {
    setState(() {
      _skip = value;
    });
  }

  Future<void> _fetchData(
    Future<CepCollectionModel?> Function(int, int) fetchCEPs,
  ) async {
    _cepCollection = await fetchCEPs(_skip, _limit);
  }

  @override
  void didChangeDependencies() {
    final MainScreenInheritedWidget(
      :skip,
      :limit,
      :cepCollection,
    ) = MainScreenInheritedWidget.of(context)!;

    _skip = skip;
    _limit = limit;
    _cepCollection = cepCollection;
    cepServiceNotifier.onCepServiceCalled.listen((_) {
      setState(() {});
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    cepServiceNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fetchCEPs = MainScreenInheritedWidget.of(context)!.fetchCEPs;

    return FutureBuilder(
      future: requestsEnabled ? _fetchData(fetchCEPs) : null,
      builder: (context, snapshot) {
        final Widget? verificationResult = verificationsHelper(
          snapshot.connectionState,
          snapshot.hasError,
        );

        if (verificationResult != null) {
          return verificationResult;
        }

        if (!requestsEnabled) {
          requestsEnabled = true;
        }

        if (_cepCollection!.results.isEmpty) {
          return const SizedBox(
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Não há nenhum CEP.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Adicione um!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }

        return CepListViewWidget(
          cepCollection: _cepCollection!,
          skip: _skip,
          limit: _limit,
          updateSkip: (int value) async {
            await _updateSkip(value);
          },
        );
      },
    );
  }
}
