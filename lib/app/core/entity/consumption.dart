import 'package:app/app/core/converters/datetime_converter.dart';
import 'package:app/app/core/entity/device.dart';
import 'package:app/app/core/entity/tariff.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'consumption',
  foreignKeys: [
    ForeignKey(
      childColumns: ['device_id'],
      parentColumns: ['id'],
      entity: Device,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['tariff_id'],
      parentColumns: ['id'],
      entity: Tariff,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
@entity
@TypeConverters([DateTimeConverter])
class Consumption {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'device_id')
  final int deviceId;

  @ColumnInfo(name: 'tariff_id')
  final int tariffId;

  final DateTime date;

  final int totalActiveMinutes;
  final int totalStandbyMinutes;
  final double totalConsumption;
  final double totalCost;

  Consumption({
    this.id,
    required this.deviceId,
    required this.tariffId,
    required this.date,
    required this.totalActiveMinutes,
    required this.totalStandbyMinutes,
    required this.totalConsumption,
    required this.totalCost,
  });

  factory Consumption.fromJson(Map<String, dynamic> json) {
    return Consumption(
      id: json['id'],
      deviceId: json['deviceId'],
      tariffId: json['tariffId'],
      date: DateTime.parse(json['date']),
      totalActiveMinutes: json['totalActiveMinutes'],
      totalStandbyMinutes: json['totalStandbyMinutes'],
      totalConsumption: json['totalConsumption'],
      totalCost: json['totalCost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceId': deviceId,
      'tariffId': tariffId,
      'date': date.toIso8601String(),
      'totalActiveMinutes': totalActiveMinutes,
      'totalStandbyMinutes': totalStandbyMinutes,
      'totalConsumption': totalConsumption,
      'totalCost': totalCost,
    };
  }

  @override
  String toString() {
    return 'Consumption{id: $id, date: $date, totalActiveMinutes: $totalActiveMinutes, totalStandbyMinutes: $totalStandbyMinutes, totalConsumption: $totalConsumption, totalCost: $totalCost}';
  }
}
