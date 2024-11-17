import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/enum/priority_level_enum.dart';
import 'package:flutter/material.dart';

extension DeviceExtension on DeviceTypeEnum {
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
              child: Text(message),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

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
              child: Text(message),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
