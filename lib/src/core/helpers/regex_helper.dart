class RegexHelper {
  static RegExp alphabeticAndAccentPattern = RegExp(
    r'[a-zA-ZáÁéÉíÍóÓúÚâÂêÊôÔãÃõÕçÇ ]',
  );
  static RegExp nonDigit = RegExp(r'[^0-9]');
  static RegExp digit = RegExp(r'[0-9]');
  static RegExp hyphenAndDot = RegExp(r'[.-]');
}
