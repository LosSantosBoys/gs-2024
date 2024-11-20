import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/enum/frequency_enum.dart';
import 'package:app/app/core/enum/priority_level_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/devices/store/device_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SaveDevicePage extends StatefulWidget {
  const SaveDevicePage({super.key, this.id});

  final String? id;

  @override
  State<SaveDevicePage> createState() => _SaveDevicePageState();
}

class _SaveDevicePageState extends State<SaveDevicePage> {
  final DeviceStore store = Modular.get<DeviceStore>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.id != "new") {
      store.loadDevice(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id != "new" ? 'Editar' : 'Salvar'} dispositivo"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 15,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Nome do dispositivo"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.name,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "É necessário informar o nome do dispositivo.";
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: "Nome do dispositivo",
                ),
              ),
              const SizedBox(height: 15),
              const Text("Tipo de dispositivo"),
              const SizedBox(height: 5),
              DropdownButtonFormField<DeviceTypeEnum>(
                items: DeviceTypeEnum.values.map((DeviceTypeEnum device) {
                  return DropdownMenuItem(
                    value: device,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(device.icon),
                        const SizedBox(width: 10),
                        Text(device.readable),
                      ],
                    ),
                  );
                }).toList(),
                value: store.type,
                onChanged: store.setType,
                decoration: const InputDecoration(
                  hintText: "Tipo de dispositivo",
                ),
                validator: (DeviceTypeEnum? value) {
                  if (value == null) {
                    return "É necessário selecionar um tipo de dispositivo.";
                  }
                  return null;
                },
              ),
              Observer(
                builder: (_) {
                  if (store.type == DeviceTypeEnum.other) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        const Text("Que tipo de dispositivo é?"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: store.device,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true && store.type == DeviceTypeEnum.other) {
                              return "É necessário informar o tipo do dispositivo.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: "Tipo do dispositivo",
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 15),
              const Text("Modelo do dispositivo"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.model,
                textCapitalization: TextCapitalization.sentences,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "É necessário informar o modelo do dispositivo.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Modelo do dispositivo",
                ),
              ),
              const SizedBox(height: 15),
              const Text("Marca do dispositivo"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.brand,
                textCapitalization: TextCapitalization.sentences,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "É necessário informar a marca do dispositivo.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Marca do dispositivo",
                ),
              ),
              const SizedBox(height: 15),
              const Text("Consumo em watts"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.wattage,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "É necessário informar o consumo em watts.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Consumo em watts",
                  suffixText: "W",
                ),
              ),
              const SizedBox(height: 15),
              const Text("Consumo em watts em stand-by"),
              const SizedBox(height: 5),
              TextField(
                controller: store.wattageStandby,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Consumo em watts em stand-by",
                  suffixText: "W",
                ),
              ),
              const SizedBox(height: 15),
              const Text("Frequência de uso"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.chosenFrequency,
                readOnly: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Observer(
                              builder: (_) => RadioListTile<FrequencyEnum>(
                                title: const Text("Diariamente"),
                                value: FrequencyEnum.daily,
                                groupValue: store.frequency,
                                onChanged: store.setFrequency,
                              ),
                            ),
                            Observer(
                              builder: (_) => RadioListTile<FrequencyEnum>(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: store.week,
                                        onChanged: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            store.week.text = '1';
                                          }
                                        },
                                      ),
                                    ),
                                    const Text(" vez(es) por semana"),
                                  ],
                                ),
                                value: FrequencyEnum.weekly,
                                groupValue: store.frequency,
                                onChanged: store.setFrequency,
                              ),
                            ),
                            Observer(
                              builder: (_) => RadioListTile<FrequencyEnum>(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: store.month,
                                        onChanged: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            store.month.text = '1';
                                          }
                                        },
                                      ),
                                    ),
                                    const Text(" vez(es) por mês"),
                                  ],
                                ),
                                value: FrequencyEnum.monthly,
                                groupValue: store.frequency,
                                onChanged: store.setFrequency,
                              ),
                            ),
                            Observer(
                              builder: (_) => RadioListTile<FrequencyEnum>(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: store.times,
                                        onChanged: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            store.times.text = '1';
                                          }
                                        },
                                      ),
                                    ),
                                    const Text(" vez(es) em "),
                                    Expanded(
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: store.days,
                                        onChanged: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            store.days.text = '1';
                                          }
                                        },
                                      ),
                                    ),
                                    const Text(" dia(s)"),
                                  ],
                                ),
                                value: FrequencyEnum.custom,
                                groupValue: store.frequency,
                                onChanged: store.setFrequency,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "É necessário informar a frequência de uso.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Frequência de uso",
                ),
              ),
              const SizedBox(height: 15),
              const Text("Horário de uso"),
              const SizedBox(height: 5),
              TextFormField(
                controller: store.beginEnd,
                readOnly: true,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Text("Início: "),
                                Expanded(
                                  child: Observer(
                                    builder: (context) => TextField(
                                      controller: TextEditingController(text: store.begin?.format(context)),
                                      keyboardType: TextInputType.datetime,
                                      readOnly: true,
                                      onTap: () async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(hour: 0, minute: 0),
                                          builder: (context, child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (time != null) {
                                          store.setBeginTime(time);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text("Fim: "),
                                Expanded(
                                  child: Observer(
                                    builder: (context) => TextField(
                                      controller: TextEditingController(text: store.end?.format(context)),
                                      keyboardType: TextInputType.datetime,
                                      readOnly: true,
                                      onTap: () async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(hour: 23, minute: 59),
                                          builder: (context, child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (time != null) {
                                          store.setEndTime(time);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).then((value) {
                    if (value == null) {
                      if (context.mounted) {
                        store.setBeginEnd(context);
                      }
                    }
                  });
                },
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "É necessário informar o horário de uso.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Horário de uso",
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nível de Prioridade"),
                        const SizedBox(height: 5),
                        DropdownButtonFormField<PriorityLevelEnum>(
                          isExpanded: true,
                          items: PriorityLevelEnum.values.map((PriorityLevelEnum priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(priority.icon, color: priority.color),
                                  const SizedBox(width: 10),
                                  Text(priority.readable),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: store.setPriority,
                          value: store.priority,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ativo"),
                      const SizedBox(height: 5),
                      Observer(
                        builder: (_) => Switch(value: store.enabled, onChanged: store.setEnabled),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Text("Notas"),
              const SizedBox(height: 5),
              SizedBox(
                height: 150,
                child: TextField(
                  controller: store.notes,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Notas",
                  ),
                  expands: true,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      store.saveDevice(context, id: widget.id);
                      Modular.to.pop();
                    }
                  },
                  child: Text(widget.id != "new" ? "Atualizar" : "Salvar"),
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
                                title: const Text("Excluir dispositivo"),
                                content: const Text("Tem certeza que deseja excluir este dispositivo?"),
                                actions: [
                                  TextButton(
                                    onPressed: Modular.to.pop,
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () => store.deleteDevice(widget.id!, context),
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
