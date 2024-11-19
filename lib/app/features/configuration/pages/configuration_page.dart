import 'package:app/app/features/configuration/pages/add_tariff_page.dart';
import 'package:app/app/features/configuration/pages/clear_data_page.dart';
import 'package:app/app/features/configuration/pages/list_tariff_page.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildConfigurationCard(
              context,
              'Adicionar Tarifa',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SaveTariffPage()),
                );
              },
            ),
            const Divider(),
                        _buildConfigurationCard(
              context,
              'Listar Tarifas',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListTariffsPage()),
                );
              },
            ),
            const Divider(),
            _buildConfigurationCard(
              context,
              'Apagar Dados',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClearDataPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigurationCard(
      BuildContext context, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}