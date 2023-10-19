import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/cep_model.dart';

import 'package:via_cep_dio/src/screens/cep_screen/components/cep_screen_body_content_widget.dart';
import 'package:via_cep_dio/src/screens/cep_screen/components/cep_custom_bottom_navigation_bar_widget.dart';

import 'package:via_cep_dio/src/services/cep_service.dart';

import 'package:via_cep_dio/src/widgets/back_button_widget.dart';

class CepScreen extends StatelessWidget {
  CepScreen({
    super.key,
    required this.cepId,
  });

  final String cepId;

  final CepService _cepService = CepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cepService.getCep(cepId),
      builder: (context, snapshot) {
        final Widget? verificationResult = verificationsHelper(
          snapshot.connectionState,
          snapshot.hasError,
        );

        if (verificationResult != null) {
          return verificationResult;
        }

        final CepModel cep = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButtonWidget(
              action: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              '${cep.localidade} - ${cep.uf}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: CepScreenBodyContentWidget(
              cep: cep,
            ),
          ),
          bottomNavigationBar: CepCustomBottomNavigationBarWidget(
            screenContext: context,
            cepId: cep.id!,
          ),
        );
      },
    );
  }
}
