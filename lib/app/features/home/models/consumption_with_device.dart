import 'package:app/app/core/entity/consumption.dart';
import 'package:app/app/core/entity/device.dart';

class ConsumptionWithDevice {
  final Device device;
  final Consumption consumption;

  ConsumptionWithDevice({
    required this.device,
    required this.consumption,
  });
}