import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SevenDaysChart extends StatelessWidget {
  const SevenDaysChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: LineChart(
        LineChartData(
          maxX: 6,
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
                      return const Text('Sun',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 2:
                      return const Text('Tue',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 4:
                      return const Text('Thu',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold));
                    case 6:
                      return const Text('Sat',
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
