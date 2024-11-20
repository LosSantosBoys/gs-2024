import 'package:app/app/app_module.dart';
import 'package:app/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // TODO: Implement background task
    print("Native called background task: $task");
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // TODO: Update frequency to 24 hours
  Workmanager().registerPeriodicTask(
    "1",
    "saveComsumption",
    frequency: const Duration(minutes: 15),
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
