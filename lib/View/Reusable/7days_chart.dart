import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SevenDaysChart extends StatelessWidget {
  final List<FlSpot> spots;
  final double maxY;
  const SevenDaysChart({Key? key, required this.spots, required this.maxY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: LineChart(
        LineChartData(
          maxX: 6,
          maxY: maxY * 1.6,
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
                        0.2,
                        0.9
                      ],
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.white.withOpacity(0.7)
                      ])),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              interval: maxY / 5,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                );
              },
            )),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 6)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 2:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 4)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 4:
                      return Text(
                          DateFormat('d-M')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 2)))
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 6:
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
