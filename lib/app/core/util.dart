import 'package:app/app/core/enum/consumption_range_enum.dart';
import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/flag_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/enum/priority_level_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DeviceExtension on DeviceTypeEnum {
  /// Retorna o tipo de dispositivo em formato legível.
  ///
  /// - `DeviceTypeEnum.light`: Lâmpada
  /// - `DeviceTypeEnum.airconditioner`: Ar Condicionado
  /// - `DeviceTypeEnum.tv`: Televisão
  /// - `DeviceTypeEnum.refrigerator`: Congelador
  /// - `DeviceTypeEnum.washingmachine`: Máquina de Lavar
  /// - `DeviceTypeEnum.heater`: Aquecedor
  /// - `DeviceTypeEnum.fan`: Ventilador
  /// - `DeviceTypeEnum.oven`: Forno
  /// - `DeviceTypeEnum.computer`: Computador
  /// - `DeviceTypeEnum.fridge`: Geladeira
  /// - `DeviceTypeEnum.other`: Outro
  String get readable {
    switch (this) {
      case DeviceTypeEnum.light:
        return 'Lâmpada';
      case DeviceTypeEnum.airconditioner:
        return 'Ar Condicionado';
      case DeviceTypeEnum.tv:
        return 'Televisão';
      case DeviceTypeEnum.refrigerator:
        return 'Congelador';
      case DeviceTypeEnum.washingmachine:
        return 'Máquina de Lavar';
      case DeviceTypeEnum.heater:
        return 'Aquecedor';
      case DeviceTypeEnum.fan:
        return 'Ventilador';
      case DeviceTypeEnum.oven:
        return 'Forno';
      case DeviceTypeEnum.computer:
        return 'Computador';
      case DeviceTypeEnum.fridge:
        return 'Geladeira';
      case DeviceTypeEnum.other:
        return 'Outro';
    }
  }

  /// Retorna o ícone que representa o tipo de dispositivo.
  ///
  /// - `DeviceTypeEnum.light`: Lâmpada
  /// - `DeviceTypeEnum.airconditioner`: Ar Condicionado
  /// - `DeviceTypeEnum.tv`: Televisão
  /// - `DeviceTypeEnum.refrigerator`: Congelador
  /// - `DeviceTypeEnum.washingmachine`: Máquina de Lavar
  /// - `DeviceTypeEnum.heater`: Aquecedor
  /// - `DeviceTypeEnum.fan`: Ventilador
  /// - `DeviceTypeEnum.oven`: Forno
  /// - `DeviceTypeEnum.computer`: Computador
  /// - `DeviceTypeEnum.fridge`: Geladeira
  /// - `DeviceTypeEnum.other`: Outro
  IconData get icon {
    switch (this) {
      case DeviceTypeEnum.light:
        return Icons.lightbulb_outline;
      case DeviceTypeEnum.airconditioner:
        return Icons.ac_unit_outlined;
      case DeviceTypeEnum.tv:
        return Icons.tv_outlined;
      case DeviceTypeEnum.refrigerator:
        return Icons.kitchen_outlined;
      case DeviceTypeEnum.washingmachine:
        return Icons.local_laundry_service_outlined;
      case DeviceTypeEnum.heater:
        return Icons.whatshot_outlined;
      case DeviceTypeEnum.fan:
        return Icons.air_outlined;
      case DeviceTypeEnum.oven:
        return Icons.local_pizza_outlined;
      case DeviceTypeEnum.computer:
        return Icons.computer_outlined;
      case DeviceTypeEnum.fridge:
        return Icons.kitchen_outlined;
      case DeviceTypeEnum.other:
        return Icons.devices_other_outlined;
    }
  }
}

/// Converte uma string em um tipo de dispositivo.
///
/// **Parâmetros**:
///  - `name`: O nome do tipo de dispositivo.
///
/// **Retorna**:
/// - Um tipo de dispositivo correspondente ao nome fornecido.
///
/// **Exemplo**:
/// ```dart
/// String name = 'Lâmpada';
/// DeviceTypeEnum type = string2Device(name);
/// print(type); // Output: DeviceTypeEnum.light
/// ```
DeviceTypeEnum string2Device(String name) {
  switch (name) {
    case 'Lâmpada':
      return DeviceTypeEnum.light;
    case 'Ar Condicionado':
      return DeviceTypeEnum.airconditioner;
    case 'Televisão':
      return DeviceTypeEnum.tv;
    case 'Congelador':
      return DeviceTypeEnum.refrigerator;
    case 'Máquina de Lavar':
      return DeviceTypeEnum.washingmachine;
    case 'Aquecedor':
      return DeviceTypeEnum.heater;
    case 'Ventilador':
      return DeviceTypeEnum.fan;
    case 'Forno':
      return DeviceTypeEnum.oven;
    case 'Computador':
      return DeviceTypeEnum.computer;
    case 'Geladeira':
      return DeviceTypeEnum.fridge;
    case 'Outro':
      return DeviceTypeEnum.other;
  }

  return DeviceTypeEnum.other;
}

extension FrequencyExtension on FrequencyEnum {
  /// Retorna a frequência em formato legível.
  ///
  /// - `FrequencyEnum.daily`: 'Diariamente'
  /// - `FrequencyEnum.weekly`: 'X vezes por semana'
  /// - `FrequencyEnum.monthly`: 'X vezes por mês'
  /// - `FrequencyEnum.custom`: 'X vezes a cada Y dias'
  ///
  /// **Parâmetros**:
  ///    - `times`: O número de vezes que a ação é realizada em um período.
  ///    - `days`: O número de dias em que a ação é realizada.
  ///
  /// **Exemplo**:
  /// ```dart
  /// FrequencyEnum.weekly.readable(times: '3'); // Output: '3 vezes por semana'
  /// ```
  String readable({String? times = '2', String? days = '4'}) {
    switch (this) {
      case FrequencyEnum.daily:
        return 'Diariamente';
      case FrequencyEnum.weekly:
        return '$times vezes por semana';
      case FrequencyEnum.monthly:
        return '$times vezes por mês';
      case FrequencyEnum.custom:
        return '$times vezes por $days dias';
    }
  }
}

extension PriorityLevelExtension on PriorityLevelEnum {
  /// Retorna o nível de prioridade em formato legível.
  ///
  /// - `PriorityLevelEnum.low`: 'Baixa'
  /// - `PriorityLevelEnum.medium`: 'Média'
  /// - `PriorityLevelEnum.high`: 'Alta'
  /// - `PriorityLevelEnum.critical`: 'Crítica'
  String get readable {
    switch (this) {
      case PriorityLevelEnum.low:
        return 'Baixa';
      case PriorityLevelEnum.medium:
        return 'Média';
      case PriorityLevelEnum.high:
        return 'Alta';
      case PriorityLevelEnum.critical:
        return 'Crítica';
    }
  }

  /// Retorna o ícone que representa o nível de prioridade.
  ///
  /// - `PriorityLevelEnum.low`: Seta para baixo
  /// - `PriorityLevelEnum.medium`: Círculo
  /// - `PriorityLevelEnum.high`: Seta para cima
  /// - `PriorityLevelEnum.critical`: Ícone de erro
  IconData get icon {
    switch (this) {
      case PriorityLevelEnum.low:
        return Icons.arrow_downward_outlined;
      case PriorityLevelEnum.medium:
        return Icons.circle_outlined;
      case PriorityLevelEnum.high:
        return Icons.arrow_upward_outlined;
      case PriorityLevelEnum.critical:
        return Icons.error_outline;
    }
  }

  /// Retorna a cor associada com o nível de prioridade.
  ///
  /// - `PriorityLevelEnum.low`: Verde
  /// - `PriorityLevelEnum.medium`: Azul
  /// - `PriorityLevelEnum.high`: Laranja
  /// - `PriorityLevelEnum.critical`: Vermelho
  Color get color {
    switch (this) {
      case PriorityLevelEnum.low:
        return Colors.green;
      case PriorityLevelEnum.medium:
        return Colors.blue;
      case PriorityLevelEnum.high:
        return Colors.orange;
      case PriorityLevelEnum.critical:
        return Colors.red;
    }
  }
}

extension ShowSnackBar on BuildContext {
  /// Mostra um SnackBar genérico, com uma mensagem e um ícone opcional.
  ///
  /// Mostra um SnackBar na parte inferior da tela com uma mensagem.
  /// Você pode personalizar o ícone e a cor de fundo.
  ///
  /// **Parâmetros**:
  ///   - `message`: A mensagem a ser exibida no SnackBar.
  ///   - `icon`: O ícone a ser exibido ao lado da mensagem. Padrão para
  /// `Icons.info`.
  ///   - `backgroundColor`: A cor de fundo do SnackBar. Padrão para
  /// `Colors.red`.
  void showSnackBar({
    required String message,
    IconData icon = Icons.info,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Mostra um SnackBar de erro, com uma mensagem e um ícone opcional.
  ///
  /// Mostra um SnackBar na parte inferior da tela com uma mensagem de erro.
  /// Você pode personalizar o ícone, a cor do ícone e a cor de fundo.
  ///
  /// **Parâmetros**:
  ///   - `message`: A mensagem a ser exibida no SnackBar.
  ///   - `icon`: O ícone a ser exibido ao lado da mensagem. Padrão para
  /// `Icons.error`.
  ///   - `iconColor`: A cor do ícone. Padrão para `Colors.white`.
  ///   - `backgroundColor`: A cor de fundo do SnackBar. Padrão para
  /// `Colors.red`.
  void showSnackBarError({
    required String message,
    IconData icon = Icons.error,
    Color iconColor = Colors.white,
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: TextStyle(color: iconColor)),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Mostra um SnackBar de sucesso, com uma mensagem e um ícone opcional.
  ///
  /// Mostra um SnackBar na parte inferior da tela com uma mensagem de
  /// sucesso.
  /// Você pode personalizar o ícone, a cor do ícone e a cor de fundo.
  ///
  /// **Parâmetros**:
  ///   - `message`: A mensagem a ser exibida no SnackBar.
  ///   - `icon`: O ícone a ser exibido ao lado da mensagem. Padrão para
  /// `Icons.check_circle`.
  ///   - `iconColor`: A cor do ícone. Padrão para `Colors.white`.
  ///   - `backgroundColor`: A cor de fundo do SnackBar. Padrão para
  /// `Colors.green`.
  void showSnackBarSuccess({
    required String message,
    IconData icon = Icons.check_circle,
    Color iconColor = Colors.white,
    Color backgroundColor = Colors.green,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: TextStyle(color: iconColor)),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

/// Converte uma string no formato 'HH:MM AM/PM' para um objeto `DateTime`.
///
/// A parte de data do objeto `DateTime` é configurada como 1 de Janeiro de
/// 2024.
///
/// **Parâmetros**:
///   - `time`: Uma string representando o horário no formato 'HH:MM AM/PM'.
/// - Retorna: Um objeto `DateTime` com o tempo especificado.
///
/// **Exemplo**:
/// ```dart
/// DateTime dateTime = string2DateTime('02:30 PM');
/// print(dateTime); // Output: 2024-01-01 14:30:00.000
/// ```
DateTime string2DateTime(String time) {
  bool isPM = time.contains('PM');
  time = time.replaceAll('AM', '').replaceAll('PM', '');

  List<String> parts = time.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  if (isPM) {
    hour += 12;
  }

  return DateTime(2024, 1, 1, hour, minute);
}

/// Compara duas strings de entrada e retorna uma lista de mapas contendo
/// as palavras que diferem entre as duas strings em cada posição.
///
/// Cada mapa na lista retornada contém duas chaves:
/// - 'word1': A palavra da primeira string de entrada na posição atual.
/// - 'word2': A palavra da segunda string de entrada na posição atual.
///
/// Se uma das strings de entrada for mais curta que a outra, as palavras
/// faltantes são representadas como strings vazias.
///
/// **Parâmetros**:
///   - input1: A primeira string de entrada para comparar.
///   - input2: A segunda string de entrada para comparar.
/// - Retorna: Uma lista de mapas contendo as palavras diferentes em cada posição.
///
/// **Exemplo**:
/// ```dart
/// differencesBetween('hello world', 'hello there');
/// // Retorna: [{'word1': 'world', 'word2': 'there'}]
/// ```
List<Map<String, dynamic>> differencesBetween(String input1, String input2) {
  List<String> words1 = input1.split(' ');
  List<String> words2 = input2.split(' ');
  int maxLength = words1.length > words2.length ? words1.length : words2.length;

  final List<Map<String, dynamic>> result = [];

  for (int i = 0; i < maxLength; i++) {
    final String word1 = i < words1.length ? words1[i] : '';
    final String word2 = i < words2.length ? words2[i] : '';

    if (word1 != word2) {
      result.add({
        'word1': word1,
        'word2': word2,
      });
    }
  }

  return result;
}

extension ConsumptionExtension on ConsumptionRangeEnum {
  /// Retorna o tipo de dispositivo em formato legível.
  /// 
  /// - `ConsumptionRangeEnum.lastDay`: Último dia
  /// - `ConsumptionRangeEnum.lastWeek`: Última semana
  /// - `ConsumptionRangeEnum.lastMonth`: Último mês
  /// - `ConsumptionRangeEnum.lastThreeMonths`: Últimos três meses
  /// - `ConsumptionRangeEnum.lastSixMonths`: Últimos seis meses
  /// - `ConsumptionRangeEnum.lastYear`: Último ano
  /// - `ConsumptionRangeEnum.allTime`: Todo o tempo
  String get readable {
    switch (this) {
      case ConsumptionRangeEnum.lastDay:
        return 'Diário';
      case ConsumptionRangeEnum.lastWeek:
        return 'Semanal';
      case ConsumptionRangeEnum.lastMonth:
        return 'Mensal';
      case ConsumptionRangeEnum.lastThreeMonths:
        return 'Trimestral';
      case ConsumptionRangeEnum.lastSixMonths:
        return 'Semestral';
      case ConsumptionRangeEnum.lastYear:
        return 'Anual';
      case ConsumptionRangeEnum.allTime:
        return 'Todo o tempo';
    }
  }
}

String formatDateBasedOnRange(DateTime date, ConsumptionRangeEnum range) {
  switch (range) {
    case ConsumptionRangeEnum.lastDay:
      return DateFormat('HH:mm').format(date);
    case ConsumptionRangeEnum.lastWeek:
      return ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"][date.weekday - 1];
    case ConsumptionRangeEnum.lastMonth:
      return DateFormat('dd/MM').format(date);
    case ConsumptionRangeEnum.lastThreeMonths:
    case ConsumptionRangeEnum.lastSixMonths:
    case ConsumptionRangeEnum.lastYear:
      return DateFormat('MM/yy').format(date);
    case ConsumptionRangeEnum.allTime:
      return "${date.year}";
  }
}

extension FlagExtension on FlagEnum {
  String readable() {
    switch (this) {
      case FlagEnum.green:
        return 'Verde';
      case FlagEnum.yellow:
        return 'Amarela';
      case FlagEnum.red:
        return 'Vermelha';
    }
  }

  Color color() {
    switch (this) {
      case FlagEnum.green:
        return Colors.green;
      case FlagEnum.yellow:
        return Colors.yellow;
      case FlagEnum.red:
        return Colors.red.shade700;
    }
  }
}