import 'package:app/app/core/enum/flag_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/configuration/store/tariff_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class SaveTariffPage extends StatefulWidget {
  const SaveTariffPage({super.key, this.id});

  final String? id;

  @override
  State<SaveTariffPage> createState() => _SaveTariffPageState();
}

class _SaveTariffPageState extends State<SaveTariffPage> {
  final TariffStore store = Modular.get<TariffStore>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (isStart) {
      store.setValidityStart(picked);
    } else {
      store.setValidityEnd(picked);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.id != 'new' && widget.id != null) {
      store.loadTariff(widget.id!);
    } else {
      store.clear();
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "O valor por kWh é obrigatório.";
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
              DropdownButtonFormField<FlagEnum>(
                items: FlagEnum.values.map((FlagEnum flag) {
                  return DropdownMenuItem(
                    value: flag,
                    child: Text(flag.readable()),
                  );
                }).toList(),
                value: store.flag,
                onChanged: store.setFlag,
                decoration: InputDecoration(
                  hintText: "Selecione a bandeira",
                  prefixIcon: Observer(builder: (_) {
                    if (store.flag == null) {
                      return const Icon(Icons.flag_outlined);
                    }

                    return Icon(Icons.flag, color: store.flag!.color());
                  }),
                ),
                validator: (value) {
                  if (value == null) {
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
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2025),
                    helpText: "Selecione o mês de referência",
                    cancelText: "Cancelar",
                    confirmText: "Selecionar",
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );

                  if (picked != null) {
                    store.month.text = DateFormat("MMMM/yyyy").format(picked);
                    store.monthDateTime = picked;
                  }
                },
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
              if (widget.id != "new")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Excluir tarifa"),
                                content: const Text("Tem certeza que deseja excluir esta tarifa?"),
                                actions: [
                                  TextButton(
                                    onPressed: Modular.to.pop,
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () => store.deleteTariff(widget.id!, context),
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
                          "Excluir",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
