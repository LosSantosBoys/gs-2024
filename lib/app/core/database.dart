import 'dart:async';

import 'package:app/app/core/converters/datetime_converter.dart';
import 'package:app/app/core/dao/consumption_dao.dart';
import 'package:app/app/core/dao/device_dao.dart';
import 'package:app/app/core/entity/consumption.dart';
import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/enum/priority_level_enum.dart';
import 'package:floor/floor.dart';
import 'package:app/app/core/entity/device.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 2, entities: [Device, Consumption])
abstract class AppDatabase extends FloorDatabase {
  DeviceDao get deviceDao;
  ConsumptionDao get consumptionDao;
}