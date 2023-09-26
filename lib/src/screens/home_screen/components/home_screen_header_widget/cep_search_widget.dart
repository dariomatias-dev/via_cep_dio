import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:via_cep_dio/src/providers/home_screen_inherited_widget.dart';

import 'package:via_cep_dio/src/utils/input_border_style.dart';

class CEPSearchWidget extends StatefulWidget {
  const CEPSearchWidget({super.key});

  @override
  State<CEPSearchWidget> createState() => _CEPSearchWidgetState();
}

class _CEPSearchWidgetState extends State<CEPSearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cepFieldController = TextEditingController();
  final FocusNode _cepFieldFocusNode = FocusNode();

  final maskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  void performUpdateCepToSearch(String cep) {
    _cepFieldFocusNode.unfocus();

    final void Function(String) updateCepToSearch =
        HomeScreenInheritedWidget.of(context)!.updateCepToSearch;

    updateCepToSearch(cep);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _cepFieldController,
        focusNode: _cepFieldFocusNode,
        inputFormatters: [maskFormatter],
        maxLength: 9,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              _cepFieldController.text = '';

              performUpdateCepToSearch('');
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
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onEditingComplete: () {
          if (_formKey.currentState!.validate()) {
            final String cep = _cepFieldController.text;

            performUpdateCepToSearch(cep);
          }
        },
        validator: (value) {
          if (value == null) {
            return 'Insirá um CEP';
          } else if (value.isNotEmpty && value.length < 9) {
            return 'Insirá um CEP válido';
          }

          return null;
        },
      ),
    );
  }
}
