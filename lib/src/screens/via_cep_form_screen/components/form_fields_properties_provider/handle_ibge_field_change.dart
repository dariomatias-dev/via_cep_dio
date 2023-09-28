import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/core/helpers/number_format_brazil_helper.dart';
import 'package:via_cep_dio/src/core/helpers/regex_helper.dart';

void handleIbgeFieldChange(TextEditingController ibgeFieldController) {
  final String ibgeFieldValue = ibgeFieldController.text.replaceAll(
    RegexHelper.nonDigit,
    '',
  );
  final value = ibgeFieldValue.isNotEmpty ? int.parse(ibgeFieldValue) : 0;
  final formattedValue = value != 0 ? numberFormatBrazilHelper(value) : '';

  ibgeFieldController.value = TextEditingValue(
    text: formattedValue,
    selection: TextSelection.collapsed(
      offset: formattedValue.length,
    ),
  );
}
