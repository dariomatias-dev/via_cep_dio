import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

import 'package:via_cep_dio/src/models/masks_model.dart';

final MasksModel masksHelper = MasksModel(
  cep: MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      "#": RegexHelper.digit,
    },
  ),
  ddd: MaskTextInputFormatter(
    mask: '+##',
    filter: {
      "#": RegexHelper.digit,
    },
  ),
);
