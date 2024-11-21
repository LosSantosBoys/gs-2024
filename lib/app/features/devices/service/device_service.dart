import 'package:app/app/core/dao/device_dao.dart';
import 'package:app/app/core/database.dart';
import 'package:app/app/core/entity/device.dart';

abstract class DeviceService {
  Future<void> saveDevice(Device device);
  Future<void> deleteDevice(int id);
  Future<void> updateDevice(Device device);
  Future<List<Device>> getDevices();
  Future<List<Device>> getEnabledDevices();
  Future<Device?> getDevice(int id);
}

class DeviceServiceImpl implements DeviceService {
  @override
  Future<void> deleteDevice(int id) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final DeviceDao deviceDao = database.deviceDao;
      final Device? device = await deviceDao.findDeviceById(id);

      if (device == null) {
        return;
      }

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

  @override
  Future<List<Device>> getEnabledDevices() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final deviceDao = database.deviceDao;
      return await deviceDao.findEnabledDevices();
    } catch (e) {
      rethrow;
    }
  }
}
