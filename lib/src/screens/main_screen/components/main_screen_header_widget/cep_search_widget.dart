import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/masks_helper.dart';

import 'package:via_cep_dio/src/providers/main_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/utils/input_border_style.dart';

class CEPSearchWidget extends StatelessWidget {
  CEPSearchWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cepFieldController = TextEditingController();

  void _performUpdateCepToSearch(BuildContext context, String cep) {
    FocusManager.instance.primaryFocus?.unfocus();

    final void Function(String) updateCepToSearch =
        MainScreenInheritedWidget.of(context)!.updateCepToSearch;

    updateCepToSearch(cep);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _cepFieldController,
        inputFormatters: [masksHelper.cep],
        maxLength: 9,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              _cepFieldController.text = '';

              _performUpdateCepToSearch(context, '');
            },
            child: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
          hintText: '58140-000',
          hintStyle: TextStyle(
            color: Colors.grey.shade700,
          ),
          enabledBorder: inputBorderStyle(Colors.grey),
          focusedBorder: inputBorderStyle(Colors.white),
          focusedErrorBorder: inputBorderStyle(Colors.red),
          errorBorder: inputBorderStyle(Colors.red),
        ),
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onEditingComplete: () {
          if (_formKey.currentState!.validate()) {
            final String cep = _cepFieldController.text;

            _performUpdateCepToSearch(context, cep);
          }
        },
        validator: (value) {
          if (value == null) {
            return 'Insira um CEP';
          } else if (value.isNotEmpty && value.length < 9) {
            return 'Insira um CEP válido';
          }

          return null;
        },
      ),
    );
  }
}
