import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:via_cep_dio/src/providers/home_screen_inherited_widget.dart';

class CEPSearchWidget extends StatefulWidget {
  const CEPSearchWidget({super.key});

  @override
  State<CEPSearchWidget> createState() => _CEPSearchWidgetState();
}

class _CEPSearchWidgetState extends State<CEPSearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cepFieldController = TextEditingController();
  final FocusNode _cepFieldFocusMode = FocusNode();

  OutlineInputBorder borderStyle(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
        ),
      );

  final maskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _cepFieldController,
        focusNode: _cepFieldFocusMode,
        inputFormatters: [maskFormatter],
        maxLength: 9,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: '58140-000',
          hintStyle: TextStyle(
            color: Colors.grey.shade700,
          ),
          enabledBorder: borderStyle(Colors.grey),
          focusedBorder: borderStyle(Colors.white),
          focusedErrorBorder: borderStyle(Colors.red),
          errorBorder: borderStyle(Colors.red),
        ),
        onEditingComplete: () {
          if (_formKey.currentState!.validate()) {
            _cepFieldFocusMode.unfocus();

            final void Function(String) updateCepToSearch =
                HomeScreenInheritedWidget.of(context)!.updateCepToSearch;

            final String cep = _cepFieldController.text;

            updateCepToSearch(cep);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insirá um CEP';
          } else if (value.length < 9) {
            return 'Insirá um CEP válido';
          }

          return null;
        },
      ),
    );
  }
}
