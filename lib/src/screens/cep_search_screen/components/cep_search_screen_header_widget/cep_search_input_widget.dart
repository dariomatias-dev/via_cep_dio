import 'package:flutter/material.dart';

import 'package:cep_dio/src/core/helpers/masks_helper.dart';

import 'package:cep_dio/src/utils/input_border_style.dart';

class CepSearchScreenFieldWidget extends StatefulWidget {
  const CepSearchScreenFieldWidget({
    super.key,
    required this.updateCepToSearch,
  });

  final void Function(String?) updateCepToSearch;

  @override
  State<CepSearchScreenFieldWidget> createState() =>
      _CepSearchScreenFieldWidgetState();
}

class _CepSearchScreenFieldWidgetState
    extends State<CepSearchScreenFieldWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cepFieldController = TextEditingController();

  void _performUpdateCepToSearch(
    BuildContext context,
    String? cep,
  ) {
    FocusManager.instance.primaryFocus?.unfocus();

    widget.updateCepToSearch(cep);
  }

  @override
  void dispose() {
    _cepFieldController.dispose();
    super.dispose();
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

              _performUpdateCepToSearch(
                context,
                null,
              );
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

            _performUpdateCepToSearch(
              context,
              cep.isNotEmpty ? cep : null,
            );

            _cepFieldController.text = '';
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
