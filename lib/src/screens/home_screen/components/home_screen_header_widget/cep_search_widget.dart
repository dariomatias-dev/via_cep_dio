import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CEPSearchWidget extends StatefulWidget {
  const CEPSearchWidget({super.key});

  @override
  State<CEPSearchWidget> createState() => _CEPSearchWidgetState();
}

class _CEPSearchWidgetState extends State<CEPSearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cepFieldController = TextEditingController();
  String cepValue = '';

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
            cepValue = _cepFieldController.text;
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
