import 'package:flutter/material.dart';

class ClearDataPage extends StatelessWidget {
  const ClearDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apagar Dados')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tem certeza que deseja apagar todos os dados?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                // TODO: Implementar lógica para apagar dados
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dados apagados com sucesso')),
                );
                Navigator.pop(context);
              },
              child: const Text('Apagar Tudo'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}