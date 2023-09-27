import 'package:intl/intl.dart';

String numberFormatBrazilHelper(int value) {
  final NumberFormat numberFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 0,
  );

  final String numberFormatted = numberFormat.format(value);

  return numberFormatted.trim();
}
