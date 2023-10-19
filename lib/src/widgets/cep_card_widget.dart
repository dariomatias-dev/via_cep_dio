import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:via_cep_dio/src/models/basic_cep_model.dart';

import 'package:via_cep_dio/src/screens/cep_form_screen/cep_form_screen.dart';
import 'package:via_cep_dio/src/screens/cep_screen/cep_screen.dart';

import 'package:via_cep_dio/src/services/cep_service.dart';

class CepCardWidget extends StatelessWidget {
  CepCardWidget({
    super.key,
    required this.basicCep,
  });

  final BasicCepModel basicCep;

  final CepService _cepService = CepService();

  @override
  Widget build(BuildContext context) {
    final BasicCepModel(
      :id,
      :bairro,
      :localidade,
      :uf,
      :cep,
    ) = basicCep;

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
                return CepFormScreen(
                  formType: 'update',
                  cepId: id,
                );
              },
            );
          } else {
            _cepService.deleteCep(id);
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
        () => CepScreen(
          cepId: id,
        ),
      ),
    );
  }
}
