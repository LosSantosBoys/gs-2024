import 'package:app/app/features/configuration/store/tariff_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SaveTariffPage extends StatefulWidget {
  const SaveTariffPage({super.key});

  @override
  State<SaveTariffPage> createState() => _SaveTariffPageState();
}

class _SaveTariffPageState extends State<SaveTariffPage> {
  final TariffStore store = Modular.get<TariffStore>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Map<String, Color> flagColors = {
    'Verde': Colors.green,
    'Amarela': Colors.yellow,
    'Vermelha': Colors.red.shade700,
  };

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    
    if (picked != null) {
      final formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if (isStart) {
        store.validityStart.text = formattedDate;
      } else {
        store.validityEnd.text = formattedDate;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Tarifa de Luz"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Text("Valor por kWh (em Reais)"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.pricePerKwh,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
                ],
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "O valor por kWh é obrigatório.";
                  }
                  final price = double.tryParse(value!);
                  if (price == null || price <= 0) {
                    return "Informe um valor válido.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Ex: 0.89",
                  suffixText: "R\$",
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 15),
              const Text("Bandeira Tarifária"),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                items: flagColors.keys.map((String flag) {
                  return DropdownMenuItem(
                    value: flag,
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: flagColors[flag]),
                        const SizedBox(width: 8),
                        Text(flag),
                      ],
                    ),
                  );
                }).toList(),
                value: store.flag.text.isEmpty ? null : store.flag.text,
                onChanged: (String? value) {
                  if (value != null) {
                    store.flag.text = value;
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Selecione a bandeira",
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Selecione uma bandeira tarifária.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text("Mês de Referência"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.month,
                decoration: const InputDecoration(
                  hintText: "Ex: Janeiro/2024",
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "O mês de referência é obrigatório.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text("Início da Vigência"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.validityStart,
                readOnly: true,
                onTap: () => _selectDate(context, true),
                decoration: const InputDecoration(
                  hintText: "Selecione a data inicial",
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "A data inicial é obrigatória.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text("Fim da Vigência"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.validityEnd,
                readOnly: true,
                onTap: () => _selectDate(context, false),
                decoration: const InputDecoration(
                  hintText: "Selecione a data final",
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "A data final é obrigatória.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text("Tarifa Ativa"),
              Observer(
                builder: (_) => SwitchListTile(
                  title: const Text("Definir como ativa"),
                  value: store.isActive,
                  onChanged: store.setActive,
                  secondary: const Icon(Icons.power_settings_new),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      store.saveTariff(context);
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Salvar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}