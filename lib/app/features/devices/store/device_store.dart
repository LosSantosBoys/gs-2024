import 'package:app/app/core/entity/device.dart';
import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/enum/priority_level_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/devices/service/device_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'device_store.g.dart';

class DeviceStore = DeviceStoreBase with _$DeviceStore;

abstract class DeviceStoreBase with Store {
  DeviceService service = Modular.get();

  TextEditingController name = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController device = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController wattage = TextEditingController();
  TextEditingController wattageStandby = TextEditingController();
  TextEditingController beginEnd = TextEditingController();
  TextEditingController notes = TextEditingController();

  // Frequency fields
  TextEditingController chosenFrequency = TextEditingController(text: "Diariamente");
  TextEditingController week = TextEditingController(text: '3');
  TextEditingController month = TextEditingController(text: '3');
  // Frequency fields - In case of multiple times in a given number of days
  TextEditingController times = TextEditingController(text: '1');
  TextEditingController days = TextEditingController(text: '3');

  @observable
  DeviceTypeEnum type = DeviceTypeEnum.light;

  @observable
  FrequencyEnum frequency = FrequencyEnum.daily;

  @observable
  TimeOfDay? begin, end;

  @observable
  PriorityLevelEnum priority = PriorityLevelEnum.low;

  @action
  void setType(DeviceTypeEnum? value) {
    if (value != null) {
      type = value;
    }
  }

  @action
  void setFrequency(FrequencyEnum? value) {
    if (value != null) {
      frequency = value;

      if (frequency == FrequencyEnum.monthly) {
        if (month.text.isEmpty) {
          month.text = '1';
        }

        if (int.parse(month.text) > 30) {
          month.text = '30';
        }

        chosenFrequency.text = frequency.readable(times: month.text);
      } else if (frequency == FrequencyEnum.weekly) {
        if (week.text.isEmpty) {
          week.text = '1';
        }

        if (int.parse(week.text) > 7) {
          week.text = '7';
        }

        chosenFrequency.text = frequency.readable(times: week.text);
      } else {
        chosenFrequency.text = frequency.readable(times: times.text, days: days.text);
      }
    }
  }

  @action
  void setBeginTime(TimeOfDay time) {
    begin = time;
  }

  @action
  void setEndTime(TimeOfDay time) {
    end = time;
  }

  void setBeginEnd(BuildContext context) {
    if (begin != null && end != null) {
      beginEnd.text = '${begin!.format(context)} - ${end!.format(context)}';
    }
  }

  void setPriority(PriorityLevelEnum? value) {
    if (value != null) {
      priority = value;
    }
  }

  void saveDevice(BuildContext context) async {
    if (!context.mounted) {
      return;
    }

    int? frequencyTimes;
    int? frequencyDays;

    if (frequency == FrequencyEnum.monthly) {
      frequencyTimes = int.tryParse(month.text) ?? 1;
    } else if (frequency == FrequencyEnum.weekly) {
      frequencyTimes = int.tryParse(week.text) ?? 1;
    } else {
      frequencyTimes = int.tryParse(times.text) ?? 1;
      frequencyDays = int.tryParse(days.text) ?? 1;
    }

    try {
      final Device device = Device(
        name: name.text,
        type: type,
        model: model.text,
        brand: brand.text,
        wattage: int.parse(wattage.text),
        wattageStandby: int.parse(wattageStandby.text),
        frequency: frequency,
        frequencyTimes: frequencyTimes,
        frequencyDays: frequencyDays,
        timeOfUse: beginEnd.text,
        priority: priority,
        notes: notes.text,
      );

      // Save device
      service.saveDevice(device);
      context.showSnackBarSuccess(message: "Dispositivo salvo com sucesso.");
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }

      context.showSnackBarError(message: "Erro ao salvar dispositivo. Tente novamente.");
    }
  }

  @action
  Future<void> loadDevice(String id) async {
    final Device? device = await service.getDevice(int.tryParse(id) ?? 0);

    if (device == null) {
      return;
    }

    name.text = device.name;
    type = device.type;
    model.text = device.model;
    brand.text = device.brand;
    wattage.text = device.wattage.toString();
    wattageStandby.text = device.wattageStandby.toString();
    frequency = device.frequency;
    beginEnd.text = device.timeOfUse;

    String? frequencyTimes = device.frequencyTimes?.toString() ?? '1';
    String? frequencyDays = device.frequencyDays?.toString() ?? '1';

    if (frequency == FrequencyEnum.monthly) {
      month.text = frequencyTimes;
    } else if (frequency == FrequencyEnum.weekly) {
      week.text = frequencyTimes;
    } else {
      days.text = frequencyDays;
      times.text = frequencyTimes;
    }

    List<String> timesOfUse = device.timeOfUse.split(' - ');
    setBeginTime(TimeOfDay.fromDateTime(string2DateTime(timesOfUse[0])));
    setEndTime(TimeOfDay.fromDateTime(string2DateTime(timesOfUse[1])));

    priority = device.priority;
    notes.text = device.notes;
  }
}
