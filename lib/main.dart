import 'package:app/app/app_module.dart';
import 'package:app/app/app_widget.dart';
import 'package:app/app/core/database.dart';
import 'package:app/app/core/entity/consumption.dart';
import 'package:app/app/core/entity/device.dart';
import 'package:app/app/core/entity/tariff.dart';
import 'package:app/app/features/home/store/home_store.dart';
import 'package:app/sqlite_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    Modular.init(AppModule());
    HomeStore store = Modular.get<HomeStore>();

    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final deviceDao = database.deviceDao;
    final tariffDao = database.tariffDao;
    final consumptionDao = database.consumptionDao;

    final List<Device> devices = await deviceDao.findEnabledDevices();
    final Tariff? tariff = await tariffDao.findActiveTariff();

    if (devices.isNotEmpty && tariff != null) {
      final double pricePerKwh = tariff.kWhValue;

      for (Device device in devices) {
        final Map<String, int> minutes = store.calculateActiveAndStandbyMinutes(device);
        final int activeMinutes = minutes['activeMinutes']!;
        final int standbyMinutes = minutes['standbyMinutes']!;

        if (activeMinutes == 0 && standbyMinutes == 0) {
          continue;
        }

        final double totalConsumption = store.calculateTotalConsumption(
          activeMinutes: activeMinutes,
          standbyMinutes: standbyMinutes,
          wattage: device.wattage,
          wattageStandby: device.wattageStandby,
        );
        final double cost = store.calculateCost(consumption: totalConsumption, price: pricePerKwh);

        Consumption consumption = Consumption(
          deviceId: device.id!,
          tariffId: tariff.id!,
          date: DateTime.now(),
          totalActiveMinutes: activeMinutes,
          totalStandbyMinutes: standbyMinutes,
          totalConsumption: totalConsumption,
          totalCost: cost,
        );

        await consumptionDao.insertConsumption(consumption);
      }
    }

    if (kDebugMode) {
      debugPrint("$task called.");
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  await initializeSqlite();

  Intl.defaultLocale = 'pt_BR';
  Intl.systemLocale = 'pt_BR';
  initializeDateFormatting('pt_BR');
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  await Workmanager().registerPeriodicTask(
    "1",
    "saveConsumption",
    frequency: const Duration(hours: 24),
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
