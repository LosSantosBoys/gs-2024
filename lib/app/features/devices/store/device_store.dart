import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/enum/priority_level_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'device_store.g.dart';

class DeviceStore = DeviceStoreBase with _$DeviceStore;

abstract class DeviceStoreBase with Store {
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

  void saveDevice() async {
    // TODO: Implement saveDevice
  }
}
