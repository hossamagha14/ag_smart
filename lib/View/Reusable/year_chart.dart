import 'package:ag_smart/View/Reusable/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearChart extends StatelessWidget {
  final List<FlSpot> spots;
  final double maxY;
  const YearChart({Key? key, required this.spots, required this.maxY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: LineChart(
        LineChartData(
          maxX: 11,
          maxY: maxY * 1.3,
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
                axisNameWidget: FittedBox(
                  child: Text(
                              text[chosenLanguage]!['Water consumption (Liter)']!,
                              style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500),
                            ),
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
