import 'package:ag_smart/View/Reusable/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThirtyDaysChart extends StatelessWidget {
  final List<FlSpot> spots;
  final double maxY;
  const ThirtyDaysChart({Key? key, required this.spots, required this.maxY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: LineChart(
        LineChartData(
          maxX: 29,
          maxY: maxY * 1.6,
          minY: 0,
          lineTouchData: LineTouchData(enabled: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              barWidth: 4,
              color: Colors.purple.shade900.withOpacity(0.7),
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                        0.5,
                        0.9
                      ],
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.white.withOpacity(0.7)
                      ])),
            ),
          ],
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
            leftTitles: AxisTitles(
                axisNameWidget: Text(
              text[chosenLanguage]!['Water consumption (Liter)']!,
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            )),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 5,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 29)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 2:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 27)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 4:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 25)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 6:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 23)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 8:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 21)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 10:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 19)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 12:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 17)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 14:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 15)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 16:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 13)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 18:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 11)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 20:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 9)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 22:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 7)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 24:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 5)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 26:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 3)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 28:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 1)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 29:
                      return Text(
                          DateFormat('d-M').format(DateTime.now()).toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            horizontalInterval: maxY / 5,
            verticalInterval: 1,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
