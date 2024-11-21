import 'package:app/app/core/enum/flag_enum.dart';
import 'package:app/app/core/enum/tariff_type_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/configuration/services/tariff_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:app/app/core/entity/tariff.dart';

part 'tariff_store.g.dart';

class TariffStore = TariffStoreBase with _$TariffStore;

abstract class TariffStoreBase with Store {
  final TariffService service = Modular.get();

  final TextEditingController pricePerKwh = TextEditingController();
  final TextEditingController month = TextEditingController();
  final TextEditingController validityStart = TextEditingController();
  final TextEditingController validityEnd = TextEditingController();

  @observable
  FlagEnum? flag;

  @observable
  TariffTypeEnum? type;

  @observable
  bool isActive = true;

  @observable
  ObservableList<Tariff> tariffs = ObservableList<Tariff>();

  @observable
  bool isLoading = false;

  @observable
  DateTime? monthDateTime;

  @observable
  DateTime? validityStartDateTime;

  @observable
  DateTime? validityEndDateTime;

  @action
  void setActive(bool value) => isActive = value;

  @action
  void setType(TariffTypeEnum? value) => type = value;

  @action
  void setFlag(FlagEnum? flag) => this.flag = flag;

  @action
  void setValidityStart(DateTime? value) {
    if (value != null) {
      validityStartDateTime = value;
      validityStart.text = DateFormat("dd/MM/yyyy").format(value);
    }
  }

  @action
  void setValidityEnd(DateTime? value) {
    if (value != null) {
      if (validityStartDateTime != null && value.isBefore(validityStartDateTime!)) {
        validityEnd.text = validityStart.text;
        validityEndDateTime = validityStartDateTime;
        return;
      }

      validityEndDateTime = value;
      validityEnd.text = DateFormat("dd/MM/yyyy").format(value);
    }
  }

  @action
  Future<void> saveTariff(BuildContext context, {String? id}) async {
    if (flag == null) {
      if (context.mounted) {
        context.showSnackBarError(message: "Selecione uma bandeira.");
      }

      return;
    }

    if (validityEndDateTime == null || validityStartDateTime == null) {
      if (context.mounted) {
        context.showSnackBarError(message: "Selecione a data de início e fim da vigência.");
      }

      return;
    }

    if (monthDateTime == null) {
      if (context.mounted) {
        context.showSnackBarError(message: "Selecione o mês de referência.");
      }

      return;
    }

    String priceAdjusted = pricePerKwh.text.trim().replaceAll(",", ".");
    double price = double.tryParse(priceAdjusted) ?? 0;

    try {
      final tariff = Tariff(
        id: id != null ? int.tryParse(id) : null,
        kWhValue: price,
        flag: flag!,
        month: monthDateTime!,
        validityStart: validityStartDateTime!,
        validityEnd: validityEndDateTime!,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        isActive: isActive,
      );

      String message = "Tarifa salva com sucesso.";

      if (tariff.id == null) {
        // Save tariff
        await service.insertTariff(tariff);
      } else {
        // Update tariff
        await service.updateTariff(tariff);
        message = "Tarifa atualizada com sucesso.";
      }

      if (tariff.isActive) {
        BuildContext? buildContext;

        if (context.mounted) {
          buildContext = context;
        }

        // ignore: use_build_context_synchronously
        await toggleTariffActive(tariff, true, context: buildContext);
      }

      if (context.mounted) {
        context.showSnackBarSuccess(message: message);
      }

      clear();
      await loadTariffs();
      Modular.to.pop();
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }

      if (context.mounted) {
        context.showSnackBarError(message: "Erro ao salvar tarifa. Tente novamente.");
      }
    }
  }

  @action
  Future<void> loadTariffs() async {
    isLoading = true;
    tariffs = ObservableList.of(await service.findAllTariffs());
    isLoading = false;
  }

  void clear() {
    pricePerKwh.clear();
    month.clear();
    validityStart.clear();
    validityEnd.clear();
    flag = null;
    monthDateTime = null;
    validityStartDateTime = null;
    validityEndDateTime = null;
  }

  @action
  Future<void> loadTariff(String id) async {
    final Tariff? tariff = await service.findTariffById(int.tryParse(id) ?? 0);

    if (tariff == null) {
      return;
    }
    clear();

    pricePerKwh.text = tariff.kWhValue.toString();
    month.text = DateFormat("MMMM/yyyy").format(tariff.month);
    monthDateTime = tariff.month;

    validityStart.text = DateFormat("dd/MM/yyyy").format(tariff.validityStart);
    validityStartDateTime = tariff.validityStart;

    validityEnd.text = DateFormat("dd/MM/yyyy").format(tariff.validityEnd);
    validityEndDateTime = tariff.validityEnd;

    flag = tariff.flag;
    isActive = tariff.isActive;
  }

  @action
  Future<void> toggleTariffActive(Tariff tariff, bool value, {BuildContext? context}) async {
    try {
      tariff = tariff.copyWith(isActive: value);

      await service.toggleTariffActive(tariff);
      await loadTariffs();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Erro ao atualizar tarifa: $e');
      }

      if (context != null && context.mounted) {
        context.showSnackBarError(message: "Erro ao atualizar tarifa. Tente novamente.");
      }
    }
  }

  @action
  Future<void> deleteTariff(String id, BuildContext context) async {
    try {
      Tariff? tariff = await service.findTariffById(int.tryParse(id) ?? 0);

      if (tariff == null) {
        if (context.mounted) {
          context.showSnackBarError(message: "Tarifa não encontrada.");
        }

        return;
      }

      await service.deleteTariff(tariff);
      await loadTariffs();

      if (context.mounted) {
        context.showSnackBarSuccess(message: "Tarifa excluída com sucesso.");
      }

      Modular.to.pushReplacementNamed('/configuration/');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Erro ao excluir tarifa: $e');
      }

      if (context.mounted) {
        context.showSnackBarError(message: "Erro ao excluir tarifa. Tente novamente.");
      }
    }
  }

  @action
  Future<void> deleteAllTariffs(BuildContext context) async {
    try {
      await service.deleteAllTariffs();
      await loadTariffs();

      if (context.mounted) {
        context.showSnackBarSuccess(message: "Todas as tarifas foram excluídas com sucesso.");
      }

      Modular.to.pop();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Erro ao excluir todas as tarifas: $e');
      }

      if (context.mounted) {
        context.showSnackBarError(message: "Erro ao excluir tarifa. Tente novamente.");
      }
    }
  }
}
