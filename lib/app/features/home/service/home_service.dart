import 'package:app/app/core/dao/consumption_dao.dart';
import 'package:app/app/core/entity/consumption.dart';
import 'package:app/app/core/database.dart';

abstract class HomeService {
  Future<void> saveConsumption(Consumption consumption);
  Future<void> deleteConsumption(int id);
  Future<void> updateConsumption(Consumption consumption);
  Future<Consumption?> getConsumption(int id);
  Future<List<Consumption>> getAllConsumptions();
  Future<List<Consumption>> getConsumptionsByDeviceId(int deviceId);
  Future<List<Consumption>> getConsumptionsByDate(DateTime date);
  Future<List<Consumption>> getConsumptionsByDateRange(DateTime startDate, DateTime endDate);
}

class HomeServiceImpl implements HomeService {
  @override
  Future<void> deleteConsumption(int id) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      final Consumption? consumption = await consumptionDao.findConsumptionById(id);

      if (consumption == null) {
        return;
      }

      await consumptionDao.deleteConsumption(consumption);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Consumption>> getAllConsumptions() async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      return await consumptionDao.findAllConsumptions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Consumption?> getConsumption(int id) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      return await consumptionDao.findConsumptionById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Consumption>> getConsumptionsByDate(DateTime date) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      return await consumptionDao.findConsumptionsByDate(date);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Consumption>> getConsumptionsByDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      return await consumptionDao.findConsumptionsByDateRange(startDate, endDate);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Consumption>> getConsumptionsByDeviceId(int deviceId) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      return await consumptionDao.findConsumptionsByDeviceId(deviceId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveConsumption(Consumption consumption) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      await consumptionDao.insertConsumption(consumption);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateConsumption(Consumption consumption) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ConsumptionDao consumptionDao = database.consumptionDao;
      await consumptionDao.updateConsumption(consumption);
    } catch (e) {
      rethrow;
    }
  }
}
