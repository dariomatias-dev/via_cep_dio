import 'package:cep_dio/src/models/form_field_property_model.dart';

String? validateValue(
  FormFieldPropertyModel formFieldProperties,
) {
  final FormFieldPropertyModel(
    :fieldTitle,
    :fieldController,
    :minLenght,
    :isRequired,
    :exactCharacterCount,
  ) = formFieldProperties;

  final String value = fieldController.text.trim();

  if (isRequired && value.isEmpty) {
    return 'Insira um valor';
  } else if (minLenght != null ? value.length < minLenght : false) {
    return 'O campo deve conter pelo menos $minLenght caracteres';
  } else if ((exactCharacterCount != null
      ? value.length < exactCharacterCount
      : false)) {
    return 'Insira um $fieldTitle válido';
  }

  return null;
}
