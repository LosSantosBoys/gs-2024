import 'package:app/app/features/home/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
