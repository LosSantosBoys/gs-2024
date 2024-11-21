import 'package:app/app/core/entity/consumption.dart';
import 'package:app/app/core/enum/consumption_range_enum.dart';
import 'package:app/app/core/enum/device_type_enum.dart';
import 'package:app/app/core/util.dart';
import 'package:app/app/features/home/models/consumption_with_device.dart';
import 'package:app/app/features/home/store/home_store.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get<HomeStore>();

  @override
  void initState() {
    super.initState();
    store.getWeeklyConsumptionAndCost();
    store.getMonthlyConsumption();
    store.getPricePerKwh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
        actions: [
          IconButton(
            onPressed: () async {
              await store.saveConsumption(context);
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
            tooltip: "Atualizar",
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Modular.to.pushNamed('/configuration/'),
            tooltip: "Configurações",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: const Text("Dispositivos"),
              onTap: () => Modular.to.pushNamed('/devices/'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 350,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Uso",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          DropdownButtonHideUnderline(
                            child: Observer(
                              builder: (_) => DropdownButton<ConsumptionRangeEnum>(
                                borderRadius: BorderRadius.circular(10),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                value: store.consumptionRange,
                                items: ConsumptionRangeEnum.values.map<DropdownMenuItem<ConsumptionRangeEnum>>(
                                  (ConsumptionRangeEnum range) {
                                    return DropdownMenuItem<ConsumptionRangeEnum>(
                                      value: range,
                                      child: Text(range.readable),
                                    );
                                  },
                                ).toList(),
                                onChanged: store.setConsumptionRange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Observer(
                          builder: (_) => FutureBuilder(
                            future: store.getConsumptionsByDateRange(store.consumptionRange) as Future<List<ConsumptionWithDevice>>?,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    "Erro ao carregar os dados: ${snapshot.error}",
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              }

                              List<ConsumptionWithDevice>? consumptionsWithDevice = snapshot.data;

                              if (consumptionsWithDevice == null || consumptionsWithDevice.isEmpty) {
                                return const Center(
                                  child: Text("Nenhum dado disponível"),
                                );
                              }

                              List<Consumption> consumptions = consumptionsWithDevice.map((e) => e.consumption).toList();

                              double maxConsumption = consumptions.map((e) => e.totalConsumption).reduce((a, b) => a > b ? a : b);

                              return LineChart(
                                LineChartData(
                                  lineTouchData: LineTouchData(
                                    enabled: true,
                                    touchTooltipData: LineTouchTooltipData(
                                      getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
                                      getTooltipItems: (touchedSpots) {
                                        return touchedSpots.map((LineBarSpot touchedSpot) {
                                          const TextStyle style = TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          );

                                          double consumption = touchedSpot.y;

                                          return LineTooltipItem('${consumption.toStringAsFixed(2)} kWh', style);
                                        }).toList();
                                      },
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  minX: 0,
                                  maxX: 6,
                                  minY: 0,
                                  maxY: maxConsumption,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(
                                        consumptions.length,
                                        (index) {
                                          return FlSpot(
                                            index.toDouble(),
                                            consumptions[index].totalConsumption,
                                          );
                                        },
                                      ),
                                      isCurved: true,
                                      barWidth: 2,
                                      isStrokeCapRound: true,
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                  ],
                                  gridData: const FlGridData(
                                    show: true,
                                    drawVerticalLine: false,
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        getTitlesWidget: (value, meta) {
                                          final int index = value.toInt();

                                          if (index >= 0 && index < consumptions.length) {
                                            DateTime date = consumptions[index].date;
                                            String formattedDate = formatDateBasedOnRange(date, store.consumptionRange);

                                            return Text(
                                              formattedDate,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            );
                                          }

                                          return const SizedBox.shrink();
                                        },
                                        interval: 1,
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 56,
                                        getTitlesWidget: (value, meta) {
                                          double cost = store.calculateCost(
                                            consumption: value,
                                            price: store.pricePerKwh,
                                          );

                                          return Text(
                                            "R\$ ${cost.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          );
                                        },
                                        interval: maxConsumption / 3,
                                      ),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Consumo de energia"),
                          const SizedBox(height: 20),
                          Observer(
                            builder: (_) => RichText(
                              text: TextSpan(
                                text: store.averageWeeklyConsumption.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: const [
                                  TextSpan(text: " "),
                                  TextSpan(
                                    text: "kWh",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text("Esta semana"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Custo de energia"),
                          const SizedBox(height: 20),
                          Observer(
                            builder: (_) => Text(
                              "R\$ ${store.averageWeeklyCost.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text("Esta semana"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Observer(
                  builder: (_) => Row(
                    children: [
                      const Text(
                        "Consumo mensal\nmédio de energia",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          text: store.averageMonthlyConsumption.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: const [
                            TextSpan(text: " "),
                            TextSpan(
                              text: "kWh",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 250,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Consumo por dispositivo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: FutureBuilder<List<ConsumptionWithDevice>>(
                          future: store.getConsumptionsByDateRange(ConsumptionRangeEnum.allTime) as Future<List<ConsumptionWithDevice>>?,
                          builder: (BuildContext context, AsyncSnapshot<List<ConsumptionWithDevice>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Erro ao carregar os dados: ${snapshot.error}",
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            List<ConsumptionWithDevice>? consumptionsWithDevice = snapshot.data;

                            if (consumptionsWithDevice == null || consumptionsWithDevice.isEmpty) {
                              return const Center(
                                child: Text("Nenhum dado disponível"),
                              );
                            }

                            Map<DeviceTypeEnum, double> consumptionsByDeviceType = {};
                            for (ConsumptionWithDevice consumptionWithDevice in consumptionsWithDevice) {
                              final DeviceTypeEnum deviceType = consumptionWithDevice.device.type;
                              final double consumption = consumptionWithDevice.consumption.totalConsumption;

                              consumptionsByDeviceType.update(
                                deviceType,
                                (value) => value + consumption,
                                ifAbsent: () => consumption,
                              );
                            }

                            int highestConsumption = consumptionsByDeviceType.values.reduce((a, b) => a > b ? a : b).ceil();
                            List<DeviceTypeEnum> deviceTypes = consumptionsByDeviceType.keys.toList();

                            return BarChart(
                              BarChartData(
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                      return BarTooltipItem(
                                        "${rod.toY.toStringAsFixed(2)} kWh",
                                        const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                gridData: const FlGridData(show: false),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        if (value.toInt() >= 0 && value.toInt() < deviceTypes.length) {
                                          return Text(
                                            deviceTypes[value.toInt()].readable,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) => Text(
                                        "${value.toStringAsFixed(2)} kWh",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      interval: highestConsumption / 3,
                                      reservedSize: 46,
                                    ),
                                  ),
                                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(show: false),
                                barGroups: List.generate(consumptionsByDeviceType.length, (index) {
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        toY: consumptionsByDeviceType.values.elementAt(index),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
