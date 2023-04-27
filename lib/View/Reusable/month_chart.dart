import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthChart extends StatelessWidget {
  final double numberOfDays;
  const MonthChart({Key? key,required this.numberOfDays}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: LineChart(
        LineChartData(
          maxX: numberOfDays,
          maxY: 170,
          lineTouchData: LineTouchData(enabled: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 10),
                const FlSpot(1, 20),
                const FlSpot(2, 30),
                const FlSpot(3, 40),
                const FlSpot(4, 20),
                const FlSpot(5, 60),
                const FlSpot(6, 70),
                const FlSpot(7, 100),
                const FlSpot(8, 90),
                const FlSpot(9, 100),
                const FlSpot(10, 110),
                const FlSpot(11, 120),
                const FlSpot(12, 130),
                const FlSpot(13, 140),
                const FlSpot(14, 150),
                const FlSpot(15, 155),
                const FlSpot(16, 156),
                const FlSpot(17, 155),
                const FlSpot(18, 150),
                const FlSpot(19, 140),
                const FlSpot(20, 130),
                const FlSpot(21, 120),
                const FlSpot(22, 110),
                const FlSpot(23, 100),
                const FlSpot(24, 90),
                const FlSpot(25, 110),
                const FlSpot(26, 70),
                const FlSpot(27, 60),
                const FlSpot(28, 50),
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
                interval: 4,
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
