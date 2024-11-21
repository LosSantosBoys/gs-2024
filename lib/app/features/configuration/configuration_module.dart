import 'package:app/app/features/configuration/pages/add_tariff_page.dart';
import 'package:app/app/features/configuration/pages/list_tariff_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/configuration_page.dart';

class ConfigurationModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const ConfigurationPage());
    r.child('/tariffs', child: (context) => const ListTariffsPage());
    r.child('/:id', child: (context) => SaveTariffPage(id: r.args.params['id']));
  }
}
