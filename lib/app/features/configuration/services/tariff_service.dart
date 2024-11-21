import 'package:app/app/core/database.dart';
import 'package:app/app/core/entity/tariff.dart';

abstract class TariffService {
  Future<List<Tariff>> findAllTariffs();
  Future<Tariff?> findTariffById(int id);
  Future<Tariff?> findActiveTariff();
  Future<void> insertTariff(Tariff tariff);
  Future<void> deleteTariff(Tariff tariff);
  Future<void> updateTariff(Tariff tariff);
}

class TariffServiceImpl implements TariffService {
  @override
  Future<void> deleteTariff(Tariff tariff) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final tariffDao = database.tariffDao;
      await tariffDao.deleteTariff(tariff);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Tariff?> findActiveTariff() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final tariffDao = database.tariffDao;
      return await tariffDao.findActiveTariff();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Tariff>> findAllTariffs() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final tariffDao = database.tariffDao;
      return await tariffDao.findAllTariffs();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Tariff?> findTariffById(int id) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final tariffDao = database.tariffDao;
      return await tariffDao.findTariffById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertTariff(Tariff tariff) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final tariffDao = database.tariffDao;
      await tariffDao.insertTariff(tariff);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTariff(Tariff tariff) async {
    try{
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

      final tariffDao = database.tariffDao;
      await tariffDao.updateTariff(tariff);
    } catch (e) {
      rethrow;
    }
  }
}