import 'package:app/app/core/util.dart';
import 'package:app/app/features/devices/store/device_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final DeviceStore store = Modular.get<DeviceStore>();

  @override
  void initState() {
    super.initState();
    store.getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos'),
      ),
      body: Observer(
        builder: (_) {
          if (store.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: store.devices.length,
            itemBuilder: (_, index) {
              final device = store.devices[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(device.type.icon),
                    title: Text(device.name),
                    subtitle: Text(device.model),
                    onTap: () {
                      Modular.to.pushNamed('${device.id}');
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
