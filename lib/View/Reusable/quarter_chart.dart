import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class QuarterChart extends StatelessWidget {
  final List<FlSpot> spots;
  final int quarter;
  const QuarterChart({Key? key, required this.spots, required this.quarter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: LineChart(
        LineChartData(
          maxX: 2,
          minX: 0,
          maxY: 3800,
          lineTouchData: LineTouchData(enabled: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
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
              interval: 500,
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
                interval: 1,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() == 0 && quarter == 1) {
                    return const Text(
                      'Jan',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 1 && quarter == 1) {
                    return const Text(
                      'Feb',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 2 && quarter == 1) {
                    return const Text(
                      'Mar',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 0 && quarter == 2) {
                    return const Text(
                      'Apr',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 1 && quarter == 2) {
                    return const Text(
                      'May',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 2 && quarter == 2) {
                    return const Text(
                      'Jun',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 0 && quarter == 3) {
                    return const Text(
                      'Jul',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 1 && quarter == 3) {
                    return const Text(
                      'Aug',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 2 && quarter == 3) {
                    return const Text(
                      'Sep',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 0 && quarter == 4) {
                    return const Text(
                      'Oct',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else if (value.toInt() == 1 && quarter == 4) {
                    return const Text(
                      'Nov',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const Text(
                      'Dec',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 500,
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
