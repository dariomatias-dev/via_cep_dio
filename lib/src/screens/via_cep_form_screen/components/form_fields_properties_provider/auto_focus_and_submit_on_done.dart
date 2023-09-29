import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/models/form_field_property_model.dart';

void autoFocusOnDone(
  final String fieldTitle,
  final List<FormFieldPropertyModel> formFieldsProperties,
) {
  int index = 0;
  bool foundFormFieldProperties = false;
  int filledFieldCount = 0;

  while (index <= formFieldsProperties.length) {
    if (index == formFieldsProperties.length) {
      index = 0;
    }

    final FormFieldPropertyModel formFieldProperties =
        formFieldsProperties[index];

    if (foundFormFieldProperties) {
      if (formFieldProperties.validValue) {
        filledFieldCount++;
      } else {
        formFieldProperties.inputFocusNode.requestFocus();
        break;
      }
    }

    if (formFieldProperties.fieldTitle == fieldTitle) {
      foundFormFieldProperties = true;
    }

    if (filledFieldCount == formFieldsProperties.length) {
      FocusManager.instance.primaryFocus?.unfocus();
      break;
    }

    index++;
  }
}