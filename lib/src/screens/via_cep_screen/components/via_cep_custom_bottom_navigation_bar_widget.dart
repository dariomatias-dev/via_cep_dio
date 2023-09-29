import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/via_cep_form_screen.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class ViaCepCustomBottomNavigationBarWidget extends StatelessWidget {
  ViaCepCustomBottomNavigationBarWidget({
    super.key,
    required this.screenContext,
    required this.viaCepId,
  });

  final BuildContext screenContext;
  final String viaCepId;

  final ViaCepService _viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                navigationFadeTransition(
                  context,
                  () {
                    return ViaCepFormScreen(
                      formType: 'update',
                      viaCepId: viaCepId,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Atualizar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(screenContext);
                _viaCepService.deleteViaCep(
                  viaCepId,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Excluir',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
