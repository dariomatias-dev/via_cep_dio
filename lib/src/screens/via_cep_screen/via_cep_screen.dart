import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_screen/components/via_cep_screen_body_content_widget.dart';
import 'package:via_cep_dio/src/screens/via_cep_screen/components/via_cep_custom_bottom_navigation_bar_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

import 'package:via_cep_dio/src/widgets/back_button_widget.dart';

class ViaCepScreen extends StatelessWidget {
  ViaCepScreen({
    super.key,
    required this.cep,
  });

  final String cep;

  final ViaCepService viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viaCepService.getViaCep(cep),
      builder: (context, snapshot) {
        final Widget? verificationResult = verificationsHelper(
          snapshot.connectionState,
          snapshot.hasError,
        );

        if (verificationResult != null) {
          return verificationResult;
        }

        final ViaCepModel viaCep = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButtonWidget(
              action: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              '${viaCep.localidade} - ${viaCep.uf}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: ViaCepScreenBodyContentWidget(
              viaCep: viaCep,
            ),
          ),
          bottomNavigationBar: ViaCepCustomBottomNavigationBarWidget(
            screenContext: context,
            viaCepId: viaCep.id,
          ),
        );
      },
    );
  }
}
