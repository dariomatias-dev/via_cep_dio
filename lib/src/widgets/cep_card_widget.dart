import 'package:cep_dio/src/core/enums/enums.dart';
import 'package:cep_dio/src/core/routes/cep_route_names.dart';
import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/helpers/navigation_fade_transition.dart';

import 'package:cep_dio/src/models/basic_cep_model.dart';

import 'package:cep_dio/src/screens/cep_form_screen/cep_form_screen.dart';
import 'package:cep_dio/src/screens/cep_screen/cep_screen.dart';

import 'package:cep_dio/src/services/cep_service.dart';

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
        color: Colors.black,
        onSelected: (action) {
          if (action == 'update') {
            navigationFadeTransition(
              context,
              CepRouteNames.cepForm,
              () {
                return CepFormScreen(
                  formType: FormTypesEnum.update,
                  cepId: id,
                );
              },
            );
          } else {
            _cepService.deleteCep(id!);
          }
        },
        itemBuilder: (context) => <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'update',
            textStyle: TextStyle(
              color: Colors.white,
            ),
            child: Text('Atualizar'),
          ),
          const PopupMenuItem(
            value: 'delete',
            textStyle: TextStyle(
              color: Colors.white,
            ),
            child: Text('Excluir'),
          ),
        ],
      ),
      onTap: () => navigationFadeTransition(
        context,
        CepRouteNames.cep,
        () => CepScreen(
          cepId: id!,
        ),
      ),
    );
  }
}
