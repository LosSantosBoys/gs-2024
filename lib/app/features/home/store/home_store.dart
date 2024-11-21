import 'package:app/app/core/entity/consumption.dart';
import 'package:app/app/core/entity/device.dart';
import 'package:app/app/core/entity/tariff.dart';
import 'package:app/app/core/enum/consumption_range_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/configuration/services/tariff_service.dart';
import 'package:app/app/features/devices/service/device_service.dart';
import 'package:app/app/features/home/models/consumption_with_device.dart';
import 'package:app/app/features/home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeService service = Modular.get();
  DeviceService deviceService = Modular.get();
  TariffService tariffService = Modular.get();

  @observable
  double pricePerKwh = 0.75;

  @observable
  ConsumptionRangeEnum consumptionRange = ConsumptionRangeEnum.lastDay;

  @observable
  double averageMonthlyConsumption = 0;

  @observable
  double averageWeeklyConsumption = 0;

  @observable
  double averageWeeklyCost = 0;

  /// Obtém o consumo e custo diário.
  @action
  Future<void> getMonthlyConsumption() async {
    try {
      List<ConsumptionWithDevice> consumptionsWithDevice = await getConsumptionsByDateRange(
        ConsumptionRangeEnum.lastMonth,
      );

      double totalConsumption = 0;

      for (ConsumptionWithDevice consumptionWithDevice in consumptionsWithDevice) {
        totalConsumption += consumptionWithDevice.consumption.totalConsumption;
      }
      averageMonthlyConsumption = totalConsumption / consumptionsWithDevice.length;

      if (averageMonthlyConsumption.isNaN) {
        averageMonthlyConsumption = 0;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Obtém o consumo e custo semanal.
  @action
  Future<void> getWeeklyConsumptionAndCost() async {
    try {
      List<ConsumptionWithDevice> consumptionsWithDevice = await getConsumptionsByDateRange(
        ConsumptionRangeEnum.lastWeek,
      );

      double totalConsumption = 0;
      double totalCost = 0;

      for (ConsumptionWithDevice consumptionWithDevice in consumptionsWithDevice) {
        totalConsumption += consumptionWithDevice.consumption.totalConsumption;
        totalCost += consumptionWithDevice.consumption.totalCost;
      }
      averageWeeklyConsumption = totalConsumption / consumptionsWithDevice.length;
      averageWeeklyCost = totalCost / consumptionsWithDevice.length;

      if (averageWeeklyConsumption.isNaN) {
        averageWeeklyConsumption = 0;
      }

      if (averageWeeklyCost.isNaN) {
        averageWeeklyCost = 0;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Define o intervalo de consumo de energia.
  ///
  /// **Parâmetros**:
  ///   - `range`: Intervalo de consumo de energia.
  @action
  void setConsumptionRange(ConsumptionRangeEnum? range) {
    if (range != null) {
      consumptionRange = range;
    }
  }

  /// Obtém o preço do kWh.
  @action
  Future<void> getPricePerKwh() async {
    try {
      Tariff? tariff = await tariffService.findActiveTariff();

      if (tariff != null) {
        pricePerKwh = tariff.kWhValue;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Retorna os consumos de energia por um intervalo de datas.
  ///
  /// **Parâmetros**:
  ///   - `range`: Intervalo de datas.
  ///
  /// **Retorno**:
  ///   - Lista de consumos de energia com dispositivos.
  @action
  Future<List<ConsumptionWithDevice>> getConsumptionsByDateRange(ConsumptionRangeEnum range) async {
    try {
      DateTime start = DateTime.now().subtract(const Duration(days: 30));
      DateTime end = DateTime.now();

      switch (range) {
        case ConsumptionRangeEnum.lastDay:
          start = DateTime.now().subtract(const Duration(days: 1));
          break;
        case ConsumptionRangeEnum.lastWeek:
          start = DateTime.now().subtract(const Duration(days: 7));
          break;
        case ConsumptionRangeEnum.lastMonth:
          start = DateTime.now().subtract(const Duration(days: 30));
          break;
        case ConsumptionRangeEnum.lastThreeMonths:
          start = DateTime.now().subtract(const Duration(days: 90));
          break;
        case ConsumptionRangeEnum.lastSixMonths:
          start = DateTime.now().subtract(const Duration(days: 180));
          break;
        case ConsumptionRangeEnum.lastYear:
          start = DateTime.now().subtract(const Duration(days: 365));
          break;
        case ConsumptionRangeEnum.allTime:
          start = DateTime(2020);
          break;
        default:
      }

      List<Consumption> consumptionsByDate = await service.getConsumptionsByDateRange(start, end);
      List<ConsumptionWithDevice> consumptionsWithDevice = [];

      for (Consumption consumption in consumptionsByDate) {
        Device? device = await deviceService.getDevice(consumption.deviceId);

        if (device == null) {
          continue;
        }

        consumptionsWithDevice.add(
          ConsumptionWithDevice(device: device, consumption: consumption),
        );
      }

      return consumptionsWithDevice;
    } catch (e) {
      rethrow;
    }
  }

  /// Salva o consumo de energia.
  ///
  /// **Parâmetros**:
  ///   - `context`: BuildContext.
  @action
  Future<void> saveConsumption(BuildContext? context) async {
    try {
      List<Device> enabledDevices = ObservableList.of(await deviceService.getEnabledDevices());
      Tariff? tariff = await tariffService.findActiveTariff();

      if (tariff == null) {
        if (context != null && context.mounted) {
          context.showSnackBarError(message: "Nenhuma tarifa ativa encontrada.");
        }
      }

      for (Device device in enabledDevices) {
        if (device.id == null) {
          continue;
        }

        final Map<String, int> minutes = calculateActiveAndStandbyMinutes(device);
        final int activeMinutes = minutes['activeMinutes']!;
        final int standbyMinutes = minutes['standbyMinutes']!;

        if (activeMinutes == 0 && standbyMinutes == 0) {
          continue;
        }

        final double totalConsumption = calculateTotalConsumption(
          activeMinutes: activeMinutes,
          standbyMinutes: standbyMinutes,
          wattage: device.wattage,
          wattageStandby: device.wattageStandby,
        );

        final double cost = calculateCost(consumption: totalConsumption, price: pricePerKwh);

        Consumption consumption = Consumption(
          deviceId: device.id!,
          tariffId: tariff!.id!,
          date: DateTime.now(),
          totalActiveMinutes: activeMinutes,
          totalStandbyMinutes: standbyMinutes,
          totalConsumption: totalConsumption,
          totalCost: cost,
        );

        await service.saveConsumption(consumption);
        await getWeeklyConsumptionAndCost();
        await getMonthlyConsumption();
      }
    } catch (e) {
      if (context != null && context.mounted) {
        context.showSnackBarError(message: "Erro ao salvar consumo. Tente novamente.");
      }
    }
  }

  /// Calcula os minutos ativos e em standby.
  ///
  /// **Parâmetros**:
  ///   - `device`: Dispositivo.
  ///
  /// **Retorno**:
  ///  - Minutos ativos e em standby.
  Map<String, int> calculateActiveAndStandbyMinutes(Device device) {
    // TimeOfUse = "10:00 AM - 10:00 PM"
    final List<String> timesOfUse = device.timeOfUse.split(' - ');
    List<DateTime> times = timesOfUse.map((String time) => string2DateTime(time)).toList();
    times.sort((a, b) => a.isBefore(b) ? -1 : 1);

    int activeMinutes = times[1].difference(times[0]).inMinutes;
    int standbyMinutes = 24 * 60 - activeMinutes;

    int adjustedActiveMinutes = activeMinutes;
    int adjustedStandbyMinutes = standbyMinutes;

    if (device.frequency == FrequencyEnum.weekly) {
      // X times in 7 days
      adjustedActiveMinutes *= (device.frequencyTimes ?? 1) ~/ 7;
      adjustedStandbyMinutes *= (device.frequencyTimes ?? 1) ~/ 7;
    } else if (device.frequency == FrequencyEnum.monthly) {
      // X times in 30 days
      adjustedActiveMinutes *= (device.frequencyTimes ?? 1) ~/ 30;
      adjustedStandbyMinutes *= (device.frequencyTimes ?? 1) ~/ 30;
    } else if (device.frequency == FrequencyEnum.custom) {
      // X times in Y days
      adjustedActiveMinutes = activeMinutes * device.frequencyTimes! ~/ device.frequencyDays!;
      adjustedStandbyMinutes = standbyMinutes * device.frequencyTimes! ~/ device.frequencyDays!;
    }

    return {
      "activeMinutes": adjustedActiveMinutes,
      "standbyMinutes": adjustedStandbyMinutes,
    };
  }

  /// Calcula o consumo total de energia.
  ///
  /// **Parâmetros**:
  ///   - `activeMinutes`: Minutos ativos.
  ///   - `standbyMinutes`: Minutos em standby.
  ///   - `wattage`: Potência em watts.
  ///   - `wattageStandby`: Potência em standby em watts.
  ///
  /// **Retorno**:
  ///   - Consumo total de energia em kWh.
  double calculateTotalConsumption({
    required int activeMinutes,
    required int standbyMinutes,
    required int wattage,
    required int wattageStandby,
  }) {
    return ((wattage * activeMinutes) + (wattageStandby * standbyMinutes)) / 60 / 1000;
  }

  /// Calcula custo do consumo de energia.
  ///
  /// **Parâmetros**:
  ///   - `Consumption`: Consumo de energia em kWh.
  ///   - `price`: Preço do kWh.
  ///
  /// **Retorno**:
  ///   - Custo do consumo de energia.
  double calculateCost({
    required double consumption,
    required double price,
  }) {
    return consumption * price;
  }
}
