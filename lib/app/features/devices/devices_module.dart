import 'package:app/app/features/devices/pages/devices_page.dart';
import 'package:app/app/features/devices/pages/save_device_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DevicesModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const DevicesPage());
    r.child(
      '/:id',
      child: (context) => SaveDevicePage(
        id: r.args.params['id'],
      ),
    );
  }
}
