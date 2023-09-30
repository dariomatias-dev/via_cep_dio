import 'package:via_cep_dio/src/models/form_field_property_model.dart';

String? validateValue(
  FormFieldPropertyModel formFieldProperties,
) {
  final FormFieldPropertyModel(
    :fieldTitle,
    :fieldController,
    :isRequired,
    :exactCharacterCount,
  ) = formFieldProperties;

  final String value = fieldController.text;

  if (isRequired && value.trim().isEmpty) {
    return 'Insira um valor';
  } else if ((exactCharacterCount != null
      ? (value.trim()).length < exactCharacterCount
      : false)) {
    return 'Insira um $fieldTitle válido';
  }

  return null;
}
