import 'package:app/app/features/configuration/configuration_module.dart';
import 'package:app/app/features/configuration/services/tariff_service.dart';
import 'package:app/app/features/configuration/store/tariff_store.dart';
import 'package:app/app/features/devices/devices_module.dart';
import 'package:app/app/features/devices/service/device_service.dart';
import 'package:app/app/features/devices/store/device_store.dart';
import 'package:app/app/features/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<DeviceService>(DeviceServiceImpl.new);
    i.addSingleton<DeviceStore>(DeviceStore.new);
    i.addSingleton<TariffService>(TariffServiceImpl.new);
    i.addSingleton<TariffStore>(TariffStore.new);
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
    r.module('/devices', module: DevicesModule());
    r.module('/configuration', module: ConfigurationModule());
  }
}
