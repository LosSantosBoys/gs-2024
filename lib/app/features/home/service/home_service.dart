import 'package:app/app/core/dao/comsumption_dao.dart';
import 'package:app/app/core/entity/comsumption.dart';
import 'package:app/app/core/database.dart';

abstract class HomeService {
  Future<void> saveComsumption(Comsumption comsumption);
  Future<void> deleteComsumption(int id);
  Future<void> updateComsumption(Comsumption comsumption);
  Future<Comsumption?> getComsumption(int id);
  Future<List<Comsumption>> getAllComsumptions();
  Future<List<Comsumption>> getComsumptionsByDeviceId(int deviceId);
  Future<List<Comsumption>> getComsumptionsByDate(DateTime date);
  Future<List<Comsumption>> getComsumptionsByDateRange(DateTime startDate, DateTime endDate);
}

class HomeServiceImpl implements HomeService {
  @override
  Future<void> deleteComsumption(int id) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      final Comsumption? comsumption = await comsumptionDao.findComsumptionById(id);

      if (comsumption == null) {
        return;
      }

      await comsumptionDao.deleteComsumption(comsumption);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comsumption>> getAllComsumptions() async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      return await comsumptionDao.findAllComsumptions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Comsumption?> getComsumption(int id) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      return await comsumptionDao.findComsumptionById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comsumption>> getComsumptionsByDate(DateTime date) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      return await comsumptionDao.findComsumptionsByDate(date);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comsumption>> getComsumptionsByDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      return await comsumptionDao.findComsumptionsByDateRange(startDate, endDate);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comsumption>> getComsumptionsByDeviceId(int deviceId) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      return await comsumptionDao.findComsumptionsByDeviceId(deviceId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveComsumption(Comsumption comsumption) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      await comsumptionDao.insertComsumption(comsumption);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateComsumption(Comsumption comsumption) async {
    try {
      final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final ComsumptionDao comsumptionDao = database.comsumptionDao;
      await comsumptionDao.updateComsumption(comsumption);
    } catch (e) {
      rethrow;
    }
  }
}
