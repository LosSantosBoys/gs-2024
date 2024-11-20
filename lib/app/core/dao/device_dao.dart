import 'package:app/app/core/entity/device.dart';
import 'package:floor/floor.dart';

@dao
abstract class DeviceDao {
  @Query('SELECT * FROM Device')
  Future<List<Device>> findAllDevices();

  @Query('SELECT * FROM Device WHERE enabled = 1')
  Future<List<Device>> findEnabledDevices();

  @Query('SELECT * FROM Device WHERE id = :id')
  Future<Device?> findDeviceById(int id);

  @insert
  Future<void> insertDevice(Device device);

  @update
  Future<void> updateDevice(Device device);

  @delete
  Future<void> deleteDevice(Device device);
}