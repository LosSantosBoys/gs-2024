import 'package:app/app/app_module.dart';
import 'package:app/app/app_widget.dart';
import 'package:app/app/features/home/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Task $task executed");
    Modular.init(AppModule());
    
    HomeStore store = Modular.get<HomeStore>();

    store.saveConsumption();

    return Future.value(true);
  });
}

void main() {
  Intl.defaultLocale = 'pt_BR';
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
