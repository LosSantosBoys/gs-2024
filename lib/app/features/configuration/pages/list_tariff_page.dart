import 'package:app/app/core/entity/tariff.dart';
import 'package:app/app/core/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:app/app/features/configuration/store/tariff_store.dart';
import 'package:intl/intl.dart';

class ListTariffsPage extends StatefulWidget {
  const ListTariffsPage({super.key});

  @override
  State<ListTariffsPage> createState() => _ListTariffsPageState();
}

class _ListTariffsPageState extends State<ListTariffsPage> {
  final TariffStore store = Modular.get<TariffStore>();

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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            itemCount: store.tariffs.length,
            itemBuilder: (context, index) {
              final Tariff tariff = store.tariffs[index];

              String month = DateFormat("MMMM/yyyy").format(tariff.month);
              String validityStart = DateFormat("dd/MM/yyyy").format(tariff.validityStart);
              String validityEnd = DateFormat("dd/MM/yyyy").format(tariff.validityEnd);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(
                    Icons.flag,
                    color: tariff.flag.color(),
                  ),
                  title: Text("R\$ ${tariff.kWhValue.toStringAsFixed(2)} kWh"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bandeira: ${tariff.flag.readable()}"),
                      Text("Mês: $month"),
                      Text("Vigência: $validityStart - $validityEnd"),
                    ],
                  ),
                  trailing: Switch(
                    value: tariff.isActive,
                    onChanged: (bool value) => store.toggleTariffActive(tariff, value),
                  ),
                  onTap: () => Modular.to.pushNamed('${tariff.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}