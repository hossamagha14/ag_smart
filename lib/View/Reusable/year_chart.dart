import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearChart extends StatelessWidget {
  const YearChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: LineChart(
        LineChartData(
          maxX: 11,
          maxY: 160,
          lineTouchData: LineTouchData(enabled: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 60),
                const FlSpot(1, 20),
                const FlSpot(2, 30),
                const FlSpot(3, 10),
                const FlSpot(4, 50),
                const FlSpot(5, 40),
                const FlSpot(6, 60),
                const FlSpot(7, 80),
                const FlSpot(8, 90),
                const FlSpot(9, 70),
                const FlSpot(10, 110),
                const FlSpot(11, 100),
              ],
              isCurved: true,
              barWidth: 4,
              gradient: LinearGradient(stops: const [
                0.5,
                1
              ], colors: [
                Colors.purple.shade900.withOpacity(0.7),
                Colors.purple.shade900.withOpacity(0.2)
              ]),
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
              interval: 20,
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
                      return const Text('Jan',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 2:
                      return const Text('Mar',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 4:
                      return const Text('May',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 6:
                      return const Text('Jul',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 8:
                      return const Text('Sep',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 10:
                      return const Text('Nov',
                          style: TextStyle(
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
            horizontalInterval: 20,
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
