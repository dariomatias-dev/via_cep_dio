import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/via_cep_cards_data_model.dart';

import 'package:via_cep_dio/src/screens/cep_list_view_screen/components/cep_list_view_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class CEPDataRequestWidget extends StatefulWidget {
  const CEPDataRequestWidget({
    super.key,
    required this.skip,
    required this.limit,
    required this.updateSkip,
  });

  final int skip;
  final int limit;
  final void Function(int) updateSkip;

  @override
  State<CEPDataRequestWidget> createState() => _CEPDataRequestWidgetState();
}

class _CEPDataRequestWidgetState extends State<CEPDataRequestWidget> {
  final ViaCepService viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viaCepService.getViaCepCardDatas(
        widget.skip,
        widget.limit,
      ),
      builder: (context, snapshot) {
        final Widget? verificationResult = verificationsHelper(
          snapshot.connectionState,
          snapshot.hasError,
        );

        if (verificationResult != null) {
          return verificationResult;
        }

        final ViaCepCardsDataModel viaCepCardsData = snapshot.data!;

        if (viaCepCardsData.results.isEmpty) {
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
          viaCepCardsData: viaCepCardsData,
          skip: widget.skip,
          limit: widget.limit,
          updateSkip: widget.updateSkip,
        );
      },
    );
  }
}
