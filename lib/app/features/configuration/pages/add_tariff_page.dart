import 'package:flutter/material.dart';

class AddTariffPage extends StatefulWidget {
  const AddTariffPage({super.key});

  @override
  State<AddTariffPage> createState() => _AddTariffPageState();
}

class _AddTariffPageState extends State<AddTariffPage> {
  final TextEditingController _tarifaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Tarifa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tarifaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o valor da tarifa',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implementar lógica para salvar a tarifa
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tarifa adicionada com sucesso')),
                );
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}