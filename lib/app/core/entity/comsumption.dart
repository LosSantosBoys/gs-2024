import 'package:app/app/core/converters/datetime_converter.dart';
import 'package:app/app/core/entity/device.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'comsumption', foreignKeys: [
  ForeignKey(
    childColumns: ['device_id'],
    parentColumns: ['id'],
    entity: Device,
    onDelete: ForeignKeyAction.cascade,
  ),
  // TODO: Add tariff foreign key
])
@entity
@TypeConverters([DateTimeConverter])
class Comsumption {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'device_id')
  final int deviceId;

  // TODO: Add tariff field

  final DateTime date;

  final int totalActiveMinutes;
  final int totalStandbyMinutes;
  final double totalComsumption;
  final double totalCost;

  Comsumption({
    this.id,
    required this.deviceId,
    required this.date,
    required this.totalActiveMinutes,
    required this.totalStandbyMinutes,
    required this.totalComsumption,
    required this.totalCost,
  });

  factory Comsumption.fromJson(Map<String, dynamic> json) {
    return Comsumption(
      id: json['id'],
      deviceId: json['deviceId'],
      date: DateTime.parse(json['date']),
      totalActiveMinutes: json['totalActiveMinutes'],
      totalStandbyMinutes: json['totalStandbyMinutes'],
      totalComsumption: json['totalComsumption'],
      totalCost: json['totalCost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceId': deviceId,
      'date': date.toIso8601String(),
      'totalActiveMinutes': totalActiveMinutes,
      'totalStandbyMinutes': totalStandbyMinutes,
      'totalComsumption': totalComsumption,
      'totalCost': totalCost,
    };
  }

  @override
  String toString() {
    return 'Comsumption{id: $id, deviceId: $deviceId, date: $date, totalActiveMinutes: $totalActiveMinutes, totalStandbyMinutes: $totalStandbyMinutes, totalComsumption: $totalComsumption, totalCost: $totalCost}';
  }
}
