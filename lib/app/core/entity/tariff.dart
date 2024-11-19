import 'package:app/app/core/converters/datetime_converter.dart';
import 'package:floor/floor.dart';

@entity
@TypeConverters([DateTimeConverter])
class Tariff {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final double kWhValue;
  final String flag;
  final String month;

  final DateTime validityStart;
  final DateTime validityEnd;
  final DateTime createdAt;
  final DateTime modifiedAt;

  final bool isActive;

  Tariff({
    this.id,
    required this.kWhValue,
    required this.flag,
    required this.month,
    required this.validityStart,
    required this.validityEnd,
    required this.createdAt,
    required this.modifiedAt,
    required this.isActive,
  });

  factory Tariff.fromJson(Map<String, dynamic> json) {
    return Tariff(
      id: json['id'],
      kWhValue: json['kWhValue'],
      flag: json['flag'],
      month: json['month'],
      validityStart: DateTime.parse(json['validityStart']),
      validityEnd: DateTime.parse(json['validityEnd']),
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kWhValue': kWhValue,
      'flag': flag,
      'month': month,
      'validityStart': validityStart.toIso8601String(),
      'validityEnd': validityEnd.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  Tariff copyWith({
    int? id,
    double? kWhValue,
    String? flag,
    String? month,
    DateTime? validityStart,
    DateTime? validityEnd,
    DateTime? createdAt,
    DateTime? modifiedAt,
    bool? isActive,
  }) {
    return Tariff(
      id: id ?? this.id,
      kWhValue: kWhValue ?? this.kWhValue,
      flag: flag ?? this.flag,
      month: month ?? this.month,
      validityStart: validityStart ?? this.validityStart,
      validityEnd: validityEnd ?? this.validityEnd,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}