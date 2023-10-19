import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/via_cep_cards_data_model.dart';

import 'package:via_cep_dio/src/notifiers/via_cep_service_notifier.dart';

import 'package:via_cep_dio/src/providers/main_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/screens/cep_list_view_screen/components/cep_list_view_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class CEPDataRequestWidget extends StatefulWidget {
  const CEPDataRequestWidget({super.key});

  @override
  State<CEPDataRequestWidget> createState() => _CEPDataRequestWidgetState();
}

class _CEPDataRequestWidgetState extends State<CEPDataRequestWidget> {
  final ViaCepService viaCepService = ViaCepService();

  int _skip = 0;
  int _limit = 0;
  ViaCepCardsDataModel? _ceps;
  bool requestsEnabled = false;

  Future<void> _updateSkip(
    int value,
  ) async {
    setState(() {
      _skip = value;
    });
  }

  Future<void> _fetchData(
    Future<ViaCepCardsDataModel?> Function(int, int) fetchCEPs,
  ) async {
    _ceps = await fetchCEPs(_skip, _limit);
  }

  @override
  void didChangeDependencies() {
    final MainScreenInheritedWidget(
      :skip,
      :limit,
      :ceps,
    ) = MainScreenInheritedWidget.of(context)!;

    _skip = skip;
    _limit = limit;
    _ceps = ceps;
    viaCepServiceNotifier.onViaCepServiceCalled.listen((_) {
      setState(() {});
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viaCepServiceNotifier.dispose();

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

        if (_ceps!.results.isEmpty) {
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

        return CEPListViewWidget(
          viaCepCardsData: _ceps!,
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
