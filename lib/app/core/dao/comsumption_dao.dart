import 'package:app/app/core/entity/comsumption.dart';
import 'package:floor/floor.dart';

@dao
abstract class ComsumptionDao {
  @Query('SELECT * FROM Comsumption')
  Future<List<Comsumption>> findAllComsumptions();

  @Query('SELECT * FROM Comsumption WHERE id = :id')
  Future<Comsumption?> findComsumptionById(int id);

  @Query('SELECT * FROM Comsumption WHERE device_id = :deviceId')
  Future<List<Comsumption>> findComsumptionsByDeviceId(int deviceId);

  @Query('SELECT * FROM Comsumption WHERE date = :date')
  Future<List<Comsumption>> findComsumptionsByDate(DateTime date);

  @Query('SELECT * FROM Comsumption WHERE date BETWEEN :startDate AND :endDate')
  Future<List<Comsumption>> findComsumptionsByDateRange(DateTime startDate, DateTime endDate);

  @insert
  Future<void> insertComsumption(Comsumption comsumption);

  @update
  Future<void> updateComsumption(Comsumption comsumption);

  @delete
  Future<void> deleteComsumption(Comsumption comsumption);
}