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
  final String timeOfUse;
  final PriorityLevelEnum priority;
  final String notes;

  Device({
    this.id,
    required this.name,
    required this.type,
    required this.model,
    required this.brand,
    required this.wattage,
    required this.wattageStandby,
    required this.frequency,
    required this.timeOfUse,
    required this.priority,
    required this.notes,
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
      timeOfUse: json['timeOfUse'],
      priority: PriorityLevelEnum.values.byName(json['priority']),
      notes: json['notes'],
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
      'timeOfUse': timeOfUse,
      'priority': priority.name,
      'notes': notes,
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
    String? timeOfUse,
    PriorityLevelEnum? priority,
    String? notes,
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
      timeOfUse: timeOfUse ?? this.timeOfUse,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
    );
  }
}
