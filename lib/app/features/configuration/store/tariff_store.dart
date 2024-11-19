import 'package:app/app/core/enum/tariff_type_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/configuration/services/tariff_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:app/app/core/entity/tariff.dart';

part 'tariff_store.g.dart';

class TariffStore = TariffStoreBase with _$TariffStore;

abstract class TariffStoreBase with Store {
  final TariffService tariffService = Modular.get();

  final TextEditingController pricePerKwh = TextEditingController();
  final TextEditingController flag = TextEditingController();
  final TextEditingController month = TextEditingController();
  final TextEditingController validityStart = TextEditingController();
  final TextEditingController validityEnd = TextEditingController();

  @observable
  TariffTypeEnum? type;

  @observable
  bool isActive = true;

  @observable
  ObservableList<Tariff> tariffs = ObservableList<Tariff>();

  @observable
  bool isLoading = false;


  @action
  void setActive(bool value) => isActive = value;

  @action
  void setType(TariffTypeEnum? value) => type = value;

  Future<void> saveTariff(BuildContext context) async {
    try {
      DateTime parsedValidityStart = DateTime.parse(validityStart.text.trim());
      DateTime parsedValidityEnd = DateTime.parse(validityEnd.text.trim());

      final tariff = Tariff(
        kWhValue: double.parse(pricePerKwh.text.trim()),
        flag: flag.text,
        month: month.text,
        validityStart: parsedValidityStart,
        validityEnd: parsedValidityEnd,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        isActive: isActive,
      );

      await tariffService.insertTariff(tariff);

      context.showSnackBarSuccess(message: "Tarifa salva com sucesso.");
      Navigator.of(context).pop();
    } catch (e) {
      context.showSnackBarError(message: "Erro ao salvar tarifa. Tente novamente.");
    }
  }

  @action
  Future<void> loadTariffs() async {
    isLoading = true;
    try {
      final loadedTariffs = await tariffService.findAllTariffs();
      tariffs = ObservableList.of(loadedTariffs);
    } catch (e) {
      tariffs = ObservableList();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleTariffActive(Tariff tariff, bool value) async {
    try {
      final updatedTariff = tariff.copyWith(isActive: value);
  
      await tariffService.updateTariff(updatedTariff);
  
      final index = tariffs.indexWhere((t) => t.id == tariff.id);
      if (index != -1) {
        tariffs[index] = updatedTariff;
      }
    } catch (e) {
      debugPrint('Erro ao atualizar tarifa: $e');
      rethrow;
  }
}
}