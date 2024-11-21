import 'package:app/app/core/entity/tariff.dart';
import 'package:floor/floor.dart';

@dao
abstract class TariffDao {
  @Query('SELECT * FROM Tariff')
  Future<List<Tariff>> findAllTariffs();

  @Query('SELECT * FROM Tariff WHERE id = :id')
  Future<Tariff?> findTariffById(int id);

  @Query('SELECT * FROM Tariff WHERE isActive = 1')
  Future<Tariff?> findActiveTariff();

  @insert
  Future<void> insertTariff(Tariff tariff);

  @delete
  Future<void> deleteTariff(Tariff tariff);

  @update
  Future<void> updateTariff(Tariff tariff);

  @Query('DELETE FROM Tariff')
  Future<void> deleteAllTariffs();

  @Query('SELECT * FROM Tariff ORDER BY id DESC LIMIT 1')
  Future<Tariff?> findLastTariff();
}