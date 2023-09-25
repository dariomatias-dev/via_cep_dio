import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_screen/components/via_cep_screen_body_content_widget.dart';
import 'package:via_cep_dio/src/screens/via_cep_screen/components/via_cep_custom_bottom_navigation_bar_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class ViaCepScreen extends StatefulWidget {
  const ViaCepScreen({
    super.key,
    required this.cep,
  });

  final String cep;

  @override
  State<ViaCepScreen> createState() => _ViaCepScreenState();
}

class _ViaCepScreenState extends State<ViaCepScreen> {
  final ViaCepService viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viaCepService.getViaCep(widget.cep),
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
            leading: Tooltip(
              message: 'Sair',
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
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
          bottomNavigationBar: const ViaCepCustomBottomNavigationBarWidget(),
        );
      },
    );
  }
}
