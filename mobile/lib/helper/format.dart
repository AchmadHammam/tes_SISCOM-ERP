import 'package:intl/intl.dart';

String formatCurrency(int number) {
  final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  return formatter.format(number);
}
