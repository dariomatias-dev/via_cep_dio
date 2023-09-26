import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:via_cep_dio/src/models/masks_model.dart';

final MasksModel masksHelper = MasksModel(
  cep: MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  ),
  ddd: MaskTextInputFormatter(
    mask: '+##',
    filter: {"#": RegExp(r'[0-9]')},
  ),
);
