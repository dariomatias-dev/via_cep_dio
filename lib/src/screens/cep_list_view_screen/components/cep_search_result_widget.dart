import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/basic_cep_model.dart';

import 'package:via_cep_dio/src/widgets/cep_card_widget.dart';

import 'package:via_cep_dio/src/services/cep_service.dart';

import 'package:via_cep_dio/src/widgets/custom_message_widget.dart';

class CepSearchResultWidget extends StatefulWidget {
  const CepSearchResultWidget({
    super.key,
    required this.cepToSearch,
  });

  final String cepToSearch;

  @override
  State<CepSearchResultWidget> createState() => _CepSearchResultWidgetState();
}

class _CepSearchResultWidgetState extends State<CepSearchResultWidget> {
  final CepService cepService = CepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BasicCepModel?>(
      future: cepService.getBasicCep(widget.cepToSearch),
      builder: (context, snapshot) {
        const String nullDataMessage = 'CEP não encontrado.';

        final Widget? verificationResult = verificationsHelper(
          snapshot.connectionState,
          snapshot.hasError,
        );

        if (verificationResult != null) {
          return verificationResult;
        }

        final BasicCepModel? basicCEP = snapshot.data;

        return Column(
          children: [
            if (snapshot.data != null)
              CepCardWidget(
                basicCep: basicCEP!,
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
