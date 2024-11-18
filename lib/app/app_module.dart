import 'package:app/app/features/configuration/configuration_module.dart';
import 'package:app/app/features/devices/devices_module.dart';
import 'package:app/app/features/devices/service/device_service.dart';
import 'package:app/app/features/devices/store/device_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<DeviceService>(DeviceServiceImpl.new);
    i.addSingleton<DeviceStore>(DeviceStore.new);
  }

  @override
  void routes(r) {
    r.module('/', module: ConfigurationModule());
  }
}
