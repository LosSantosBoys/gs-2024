import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';

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