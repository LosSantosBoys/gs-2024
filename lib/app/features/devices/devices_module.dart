import 'package:app/app/features/devices/pages/save_device_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DevicesModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    // TODO: Implementar edição de dispositivo
    r.child('/', child: (context) => SaveDevicePage());
    // TODO: Adicionar lista de dispositivos  
  }
}
