import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

void autoFocusOnDone(
  final String fieldTitle,
  final List<FormFieldPropertyModel> formFieldsProperties,
) {
  int index = 0;
  int? foundFormFieldPropertiesIndex;
  int filledFieldCount = 0;

  while (index <= formFieldsProperties.length) {
    if (index == formFieldsProperties.length) {
      index = 0;
    }

    final FormFieldPropertyModel formFieldProperties =
        formFieldsProperties[index];
    if (foundFormFieldPropertiesIndex != null) {
      final String value = formFieldProperties.fieldController.text;
      final int? exactCharacterCount = formFieldProperties.exactCharacterCount;

      final bool valueIsEmpty = value.trim().isEmpty;
      final bool isRequired = formFieldProperties.isRequired;
      final bool isNotRequiredAndBeforeIndex =
          !isRequired && index < foundFormFieldPropertiesIndex;
      final bool isShorterThanExactCount = exactCharacterCount != null
          ? (value.trim()).length < exactCharacterCount
          : false;

      if ((!isRequired && valueIsEmpty) ||
          isNotRequiredAndBeforeIndex ||
          !isShorterThanExactCount) {
        filledFieldCount++;
      }

      if (filledFieldCount != formFieldsProperties.length) {
        if ((valueIsEmpty || isShorterThanExactCount) &&
            (!isNotRequiredAndBeforeIndex || isShorterThanExactCount)) {
          formFieldProperties.inputFocusNode.requestFocus();
          break;
        }
      }
    }

    if (formFieldProperties.fieldTitle == fieldTitle) {
      foundFormFieldPropertiesIndex = index;
    }

    if (filledFieldCount == formFieldsProperties.length) {
      FocusManager.instance.primaryFocus?.unfocus();
      break;
    }

    index++;
  }
}
