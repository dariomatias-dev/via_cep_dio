import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MasksModel {
  MasksModel({
    required this.cep,
    required this.ddd,
  });

  final MaskTextInputFormatter cep;
  final MaskTextInputFormatter ddd;
}
