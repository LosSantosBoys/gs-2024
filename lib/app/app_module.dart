import 'package:app/app/features/devices/devices_module.dart';
import 'package:app/app/features/devices/service/device_service.dart';
import 'package:app/app/features/devices/store/device_store.dart';
import 'package:app/app/features/home/home_module.dart';
import 'package:app/app/features/home/service/home_service.dart';
import 'package:app/app/features/home/store/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<DeviceService>(DeviceServiceImpl.new);
    i.addSingleton<DeviceStore>(DeviceStore.new);
    i.addSingleton<HomeService>(HomeServiceImpl.new);
    i.addSingleton<HomeStore>(HomeStore.new);
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
    r.module('/devices', module: DevicesModule());
  }
}
