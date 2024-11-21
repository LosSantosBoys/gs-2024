import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formata um campo de texto para aceitar valores monetários.
class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    decimalDigits: 2,
    symbol: '',
  );

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove qualquer caractere que não seja dígito
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Converte o valor para double e divide por 100
    double value = double.parse(digitsOnly) / 100;
    String formattedValue = _formatter.format(value);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
