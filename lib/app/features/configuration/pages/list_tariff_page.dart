import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:app/app/features/configuration/store/tariff_store.dart';

class ListTariffsPage extends StatefulWidget {
  const ListTariffsPage({super.key});

  @override
  State<ListTariffsPage> createState() => _ListTariffsPageState();
}

class _ListTariffsPageState extends State<ListTariffsPage> {
  final TariffStore store = Modular.get<TariffStore>();

  final Map<String, Color> flagColors = {
    'Verde': Colors.green,
    'Amarela': Colors.yellow,
    'Vermelha': Colors.red.shade700,
  };

  @override
  void initState() {
    super.initState();
    store.loadTariffs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarifas"),
      ),
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.tariffs.isEmpty) {
            return const Center(child: Text("Nenhuma tarifa cadastrada."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: store.tariffs.length,
            itemBuilder: (context, index) {
              final tariff = store.tariffs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(
                    Icons.flag,
                    color: flagColors[tariff.flag]
                  ),
                  title: Text("R\$ ${tariff.kWhValue.toStringAsFixed(2)} por kWh"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bandeira: ${tariff.flag}"),
                      Text("Mês: ${tariff.month}"),
                      Text("Vigência: ${tariff.validityStart} - ${tariff.validityEnd}"),
                    ],
                  ),
                  trailing: Switch(
                    value: tariff.isActive,
                    onChanged: (bool value) {
                      store.toggleTariffActive(tariff, value);
                    },
                  ),
                  onTap: () {
                    Modular.to.pushNamed('/tariffs/edit', arguments: tariff);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}