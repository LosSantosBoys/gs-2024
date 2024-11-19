import 'package:app/app/app_module.dart';
import 'package:app/app/app_widget.dart';
import 'package:app/sqlite_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  await initializeSqlite();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}