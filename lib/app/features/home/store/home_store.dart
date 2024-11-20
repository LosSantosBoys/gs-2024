import 'package:app/app/core/entity/comsumption.dart';
import 'package:app/app/core/entity/device.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/devices/service/device_service.dart';
import 'package:app/app/features/home/service/home_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeService service = Modular.get();
  DeviceService deviceService = Modular.get();

  // TODO: Replace with tariff value
  final double pricePerKwh = 0.75;

  @action
  Future<void> saveComsumption() async {
    try {
      List<Device> devices = await deviceService.getEnabledDevices();

      for (Device device in devices) {
        if (device.id == null) {
          continue;
        }

        final Map<String, int> minutes = calculateActiveAndStandbyMinutes(device);
        final int activeMinutes = minutes['activeMinutes']!;
        final int standbyMinutes = minutes['standbyMinutes']!;

        if (activeMinutes == 0 && standbyMinutes == 0) {
          continue;
        }

        final double totalComsumption = calculateTotalComsumption(
          activeMinutes: activeMinutes,
          standbyMinutes: standbyMinutes,
          wattage: device.wattage,
          wattageStandby: device.wattageStandby,
        );

        final double cost = calculateCost(comsumption: totalComsumption, price: pricePerKwh);

        Comsumption comsumption = Comsumption(
          deviceId: device.id!,
          date: DateTime.now(),
          totalActiveMinutes: activeMinutes,
          totalStandbyMinutes: standbyMinutes,
          totalComsumption: totalComsumption,
          totalCost: cost,
        );

        await service.saveComsumption(comsumption);
      }
    } catch (e) {
      rethrow;
    }
  }

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

  double calculateTotalComsumption({
    required int activeMinutes,
    required int standbyMinutes,
    required int wattage,
    required int wattageStandby,
  }) {
    return ((wattage * activeMinutes) + (wattageStandby * standbyMinutes)) / 60 / 1000;
  }

  double calculateCost({
    required double comsumption,
    required double price,
  }) {
    return comsumption * price;
  }
}
