import 'package:intl/intl.dart';

class HumansFormats {
  static String number(double number, [int decimal = 0]) {
    final formattedHumans =
        NumberFormat.compactCurrency(decimalDigits: decimal, symbol: '', locale: 'en')
            .format(number);

    return formattedHumans;
  }
}
