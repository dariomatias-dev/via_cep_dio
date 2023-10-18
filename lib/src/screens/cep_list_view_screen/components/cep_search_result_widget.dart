import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

import 'package:via_cep_dio/src/screens/main_screen/components/main_screen_body_content_widget/via_cep_card_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

import 'package:via_cep_dio/src/widgets/custom_message_widget.dart';

class CEPSearchResultWidget extends StatefulWidget {
  const CEPSearchResultWidget({
    super.key,
    required this.cepToSearch,
  });

  final String cepToSearch;

  @override
  State<CEPSearchResultWidget> createState() => _CEPSearchResultWidgetState();
}

class _CEPSearchResultWidgetState extends State<CEPSearchResultWidget> {
  final ViaCepService viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viaCepService.getViaCepCardData(widget.cepToSearch),
      builder: (context, snapshot) {
        const String nullDataMessage = 'CEP não encontrado.';

        final Widget? verificationResult = verificationsHelper(
          snapshot.connectionState,
          snapshot.hasError,
        );

        if (verificationResult != null) {
          return verificationResult;
        }

        final ViaCepCardModel? viaCep = snapshot.data;

        return Column(
          children: [
            if (snapshot.data != null)
              ViaCepCardWidget(
                viaCep: viaCep!,
              )
            else
              const CustomMessageWidget(
                content: nullDataMessage,
              ),
          ],
        );
      },
    );
  }
}
