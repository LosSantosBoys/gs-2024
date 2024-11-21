import 'package:app/app/app_module.dart';
import 'package:app/app/app_widget.dart';
import 'package:app/sqlite_init.dart';
import 'package:app/app/features/home/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Task $task executed");
    Modular.init(AppModule());
    
    HomeStore store = Modular.get<HomeStore>();

    store.saveConsumption(null);

    return Future.value(true);
  });
}

Future<void> main() async {
  await initializeSqlite();

  Intl.defaultLocale = 'pt_BR';
  Intl.systemLocale = 'pt_BR';
  initializeDateFormatting('pt_BR');
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // TODO: Update frequency to 24 hours
  Workmanager().registerPeriodicTask(
    "1",
    "saveConsumption",
    frequency: const Duration(minutes: 15),
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}