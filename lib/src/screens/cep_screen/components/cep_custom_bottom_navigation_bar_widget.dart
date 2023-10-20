import 'package:cep_dio/src/core/enums/enums.dart';
import 'package:cep_dio/src/core/routes/cep_route_names.dart';
import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:cep_dio/src/screens/cep_form_screen/cep_form_screen.dart';

import 'package:cep_dio/src/services/cep_service.dart';

class CepCustomBottomNavigationBarWidget extends StatelessWidget {
  CepCustomBottomNavigationBarWidget({
    super.key,
    required this.screenContext,
    required this.cepId,
  });

  final BuildContext screenContext;
  final String cepId;

  final CepService _cepService = CepService();

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
                  CepRouteNames.cepForm,
                  () {
                    return CepFormScreen(
                      formType: FormTypesEnum.update,
                      cepId: cepId,
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
                _cepService.deleteCep(
                  cepId,
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
