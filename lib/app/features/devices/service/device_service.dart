import 'package:app/app/core/database.dart';
import 'package:app/app/core/entity/device.dart';

abstract class DeviceService {
  Future<void> saveDevice(Device device);
  Future<void> deleteDevice(Device device);
  Future<void> updateDevice(Device device);
  Future<List<Device>> getDevices();
  Future<Device?> getDevice(int id);
}

class DeviceServiceImpl implements DeviceService {
  @override
  Future<void> deleteDevice(Device device) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final deviceDao = database.deviceDao;
      await deviceDao.deleteDevice(device);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Device>> getDevices() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final deviceDao = database.deviceDao;
      return await deviceDao.findAllDevices();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveDevice(Device device) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final deviceDao = database.deviceDao;
      await deviceDao.insertDevice(device);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateDevice(Device device) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final deviceDao = database.deviceDao;
      await deviceDao.updateDevice(device);
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Device?> getDevice(int id) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final deviceDao = database.deviceDao;
      return await deviceDao.findDeviceById(id);
    } catch (e) {
      rethrow;
    }
  }
}
