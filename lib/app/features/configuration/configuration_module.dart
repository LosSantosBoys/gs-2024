import 'package:flutter_modular/flutter_modular.dart';

import 'pages/configuration_page.dart';

class ConfigurationModule extends Module {
  @override
  void binds(Injector i) {
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ConfigurationPage());
  }
}