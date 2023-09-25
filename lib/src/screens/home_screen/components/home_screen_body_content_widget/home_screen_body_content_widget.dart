import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

import 'package:via_cep_dio/src/providers/home_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_body_content_widget/cep_add_button_widget.dart';
import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_body_content_widget/via_cep_card_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class HomeScreenBodyContentWidget extends StatefulWidget {
  const HomeScreenBodyContentWidget({super.key});

  @override
  State<HomeScreenBodyContentWidget> createState() =>
      _HomeScreenBodyContentWidgetState();
}

class _HomeScreenBodyContentWidgetState
    extends State<HomeScreenBodyContentWidget> {
  final ViaCepService viaCepService = ViaCepService();

  Widget? _verifications(
    ConnectionState connectionState,
    bool hasError,
  ) {
    if (connectionState == ConnectionState.waiting) {
      return const SizedBox(
        height: 140.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (hasError) {
      return const CustomMessageWidget(
        content: 'Ocorreu um problema ao carregar os dados',
      );
    }

    return null;
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

          final Widget? verificationResult = _verifications(
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
              const CepAddButtonWidget(),
            ],
          );
        },
      );
    }

    return FutureBuilder(
      future: viaCepService.getViaCepCardDatas(),
      builder: (context, snapshot) {
        final Widget? verificationResult = _verifications(
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
              children: viaCeps.map((viaCep) {
                return ViaCepCardWidget(
                  viaCep: viaCep,
                );
              }).toList(),
            ),
            const CepAddButtonWidget(),
          ],
        );
      },
    );
  }
}

class CustomMessageWidget extends StatelessWidget {
  const CustomMessageWidget({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Center(
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
