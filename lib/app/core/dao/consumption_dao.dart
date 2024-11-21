import 'package:app/app/core/entity/consumption.dart';
import 'package:floor/floor.dart';

@dao
abstract class ConsumptionDao {
  @Query('SELECT * FROM consumption')
  Future<List<Consumption>> findAllConsumptions();

  @Query('SELECT * FROM consumption WHERE id = :id')
  Future<Consumption?> findConsumptionById(int id);

  @Query('SELECT * FROM consumption WHERE device_id = :deviceId')
  Future<List<Consumption>> findConsumptionsByDeviceId(int deviceId);

  @Query('SELECT * FROM consumption WHERE date = :date')
  Future<List<Consumption>> findConsumptionsByDate(DateTime date);

  @Query('SELECT * FROM consumption WHERE date BETWEEN :startDate AND :endDate')
  Future<List<Consumption>> findConsumptionsByDateRange(DateTime startDate, DateTime endDate);

  @insert
  Future<void> insertConsumption(Consumption consumption);

  @update
  Future<void> updateConsumption(Consumption consumption);

  @delete
  Future<void> deleteConsumption(Consumption consumption);
}