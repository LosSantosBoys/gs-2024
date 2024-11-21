import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/enum/priority_level_enum.dart';
import 'package:floor/floor.dart';

@entity
class Device {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  
  final String name;
  final DeviceTypeEnum type;
  final String model;
  final String brand;
  final int wattage;
  final int wattageStandby;
  final FrequencyEnum frequency;
  final int? frequencyDays;
  final int? frequencyTimes;
  final String timeOfUse;
  final PriorityLevelEnum priority;
  final String notes;
  final bool enabled;

  Device({
    this.id,
    required this.name,
    required this.type,
    required this.model,
    required this.brand,
    required this.wattage,
    required this.wattageStandby,
    required this.frequency,
    this.frequencyDays,
    this.frequencyTimes,
    required this.timeOfUse,
    required this.priority,
    required this.notes,
    required this.enabled,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      type: DeviceTypeEnum.values.byName(json['type']),
      model: json['model'],
      brand: json['brand'],
      wattage: json['wattage'],
      wattageStandby: json['wattageStandby'],
      frequency: FrequencyEnum.values.byName(json['frequency']),
      frequencyDays: json['frequencyDays'],
      frequencyTimes: json['frequencyTimes'],
      timeOfUse: json['timeOfUse'],
      priority: PriorityLevelEnum.values.byName(json['priority']),
      notes: json['notes'],
      enabled: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'model': model,
      'brand': brand,
      'wattage': wattage,
      'wattageStandby': wattageStandby,
      'frequency': frequency.name,
      'frequencyDays': frequencyDays,
      'frequencyTimes': frequencyTimes,
      'timeOfUse': timeOfUse,
      'priority': priority.name,
      'notes': notes,
      'enabled': enabled,
    };
  }

  Device copyWith({
    int? id,
    String? name,
    DeviceTypeEnum? type,
    String? model,
    String? brand,
    int? wattage,
    int? wattageStandby,
    FrequencyEnum? frequency,
    int? frequencyDays,
    int? frequencyTimes,
    String? timeOfUse,
    PriorityLevelEnum? priority,
    String? notes,
    bool? enabled,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      wattage: wattage ?? this.wattage,
      wattageStandby: wattageStandby ?? this.wattageStandby,
      frequency: frequency ?? this.frequency,
      frequencyDays: frequencyDays ?? this.frequencyDays,
      frequencyTimes: frequencyTimes ?? this.frequencyTimes,
      timeOfUse: timeOfUse ?? this.timeOfUse,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      enabled: enabled ?? this.enabled,
    );
  }
}
