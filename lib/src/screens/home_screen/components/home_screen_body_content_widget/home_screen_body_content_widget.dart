import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/navigation_fade_transition.dart';
import 'package:via_cep_dio/src/core/helpers/verifications_helper.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

import 'package:via_cep_dio/src/providers/home_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/screens/add_via_cep_screen/add_via_cep_screen.dart';
import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_body_content_widget/via_cep_card_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

import 'package:via_cep_dio/src/widgets/custom_message_widget.dart';
import 'package:via_cep_dio/src/widgets/default_button_widget.dart';

class HomeScreenBodyContentWidget extends StatefulWidget {
  const HomeScreenBodyContentWidget({super.key});

  @override
  State<HomeScreenBodyContentWidget> createState() =>
      _HomeScreenBodyContentWidgetState();
}

class _HomeScreenBodyContentWidgetState
    extends State<HomeScreenBodyContentWidget> {
  final ViaCepService viaCepService = ViaCepService();

  Padding get _cepAddButtonWidget => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: DefaultButtonWidget(
          text: 'Adicionar novo CEP',
          action: () {
            navigationFadeTransition(
              context,
              () => const AddViaCepScreen(),
            );
          },
        ),
      );

  void _updateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String cepToSearch =
        HomeScreenInheritedWidget.of(context)!.cepToSearch;

    if (cepToSearch.isNotEmpty) {
      return FutureBuilder(
        future: viaCepService.getViaCepCardData(cepToSearch),
        builder: (context, snapshot) {
          const String nullDataMessage = 'CEP não encontrado';

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
                  updateScreen: _updateScreen,
                )
              else
                const CustomMessageWidget(
                  content: nullDataMessage,
                ),
              _cepAddButtonWidget,
            ],
          );
        },
      );
    }

    return FutureBuilder(
      future: viaCepService.getViaCepCardDatas(),
      builder: (context, snapshot) {
        final Widget? verificationResult = verificationsHelper(
          snapshot.connectionState,
          snapshot.hasError,
        );

        if (verificationResult != null) {
          return verificationResult;
        }

        final List<ViaCepCardModel> viaCeps = snapshot.data!;

        return Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: viaCeps.map((viaCep) {
                return ViaCepCardWidget(
                  viaCep: viaCep,
                  updateScreen: _updateScreen,
                );
              }).toList(),
            ),
            _cepAddButtonWidget,
          ],
        );
      },
    );
  }
}
