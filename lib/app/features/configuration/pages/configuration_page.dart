import 'package:app/app/features/configuration/store/tariff_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final TariffStore store = Modular.get<TariffStore>();

  @override
  void initState() {
    super.initState();
    store.loadTariffs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Adicionar Tarifa"),
              onTap: () => Modular.to.pushNamed('new'),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Listar Tarifas"),
              onTap: () => Modular.to.pushNamed('tariffs'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Excluir Todas as Tarifas"),
                        content: const Text("Tem certeza que deseja excluir todas as tarifas?"),
                        actions: [
                          TextButton(
                            onPressed: Modular.to.pop,
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () => store.deleteAllTariffs(context),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text(
                              "Excluir",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Excluir Todas as Tarifas",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
