import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

import 'package:via_cep_dio/src/screens/via_cep_form_screen/via_cep_form_screen.dart';
import 'package:via_cep_dio/src/screens/via_cep_screen/via_cep_screen.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class ViaCepCardWidget extends StatelessWidget {
  ViaCepCardWidget({
    super.key,
    required this.viaCep,
  });

  final ViaCepCardModel viaCep;

  final ViaCepService _viaCepService = ViaCepService();

  @override
  Widget build(BuildContext context) {
    final ViaCepCardModel(
      :id,
      :bairro,
      :localidade,
      :uf,
      :cep,
    ) = viaCep;

    return ListTile(
      leading: const Icon(Icons.map),
      title: Text(
        '$bairro - $localidade/$uf',
      ),
      subtitle: Text(cep),
      trailing: PopupMenuButton(
        onSelected: (action) {
          if (action == 'update') {
            navigationFadeTransition(
              context,
              () {
                return ViaCepFormScreen(
                  formType: 'update',
                  viaCepId: id,
                );
              },
            );
          } else {
            _viaCepService.deleteViaCep(id);
          }
        },
        itemBuilder: (context) => <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'update',
            child: Text('Atualizar'),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Text('Excluir'),
          ),
        ],
      ),
      onTap: () => navigationFadeTransition(
        context,
        () => ViaCepScreen(
          viaCepId: id,
        ),
      ),
    );
  }
}
