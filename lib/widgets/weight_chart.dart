import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class WeightChart extends StatelessWidget {
  final List<Map<String, dynamic>> weights;

  const WeightChart({super.key, required this.weights});

  @override
  Widget build(BuildContext context) {
    if (weights.isEmpty) {
      return const Center(child: Text('No data to display.'));
    }

    final spots = weights.asMap().entries.map((entry) {
      final index = entry.key;
      final weight = entry.value['weight'] as double;
      return FlSpot(index.toDouble(), weight);
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SizedBox(
        height: 220,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.2),
                ),
                dotData: FlDotData(show: false),
              )
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    space: 8,
                    child: Text(
                      '${value.toInt()}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    space: 8,
                    child: Text(
                      value.toStringAsFixed(0),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.black12),
                left: BorderSide(color: Colors.black12),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 10,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.black12,
                strokeWidth: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
