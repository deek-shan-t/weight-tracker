import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightChart extends StatelessWidget {
  final List<Map<String, dynamic>> weights;
  final double? goalWeight;

  const WeightChart({Key? key, required this.weights, this.goalWeight}) : super(key: key);

  List<FlSpot> _generateGraphData() {
    return weights.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['weight']);
    }).toList();
  }

  List<String> _generateDateLabels() {
    return weights.map((e) {
      final date = DateTime.parse(e['date']);
      return DateFormat.Md().format(date);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (weights.isEmpty) {
      return Center(
        child: Text(
          'No Data Yet',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      );
    }

    final spots = _generateGraphData();
    final labels = _generateDateLabels();

    final double minWeight = weights.map((e) => e['weight'] as double).reduce((a, b) => a < b ? a : b);
    final double maxWeight = weights.map((e) => e['weight'] as double).reduce((a, b) => a > b ? a : b);
    final double minY = (goalWeight != null && goalWeight! < minWeight) 
        ? goalWeight! - 5 
        : (minWeight - 5).clamp(0, minWeight);
    final double maxY = (goalWeight != null && goalWeight! > maxWeight) 
        ? goalWeight! + 5 
        : maxWeight + 5;

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) => Text(
                value.toInt().toString(),
                style: TextStyle(color: Colors.white54, fontSize: 10),
              ),
              interval: 5,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                if (value.toInt() >= 0 && value.toInt() < labels.length) {
                  return Text(
                    labels[value.toInt()],
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  );
                }
                return Text('');
              },
              interval: 1,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        extraLinesData: goalWeight != null
            ? ExtraLinesData(horizontalLines: [
                HorizontalLine(
                  y: goalWeight!,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  strokeWidth: 5,
                  dashArray: [5, 5],
                  label: HorizontalLineLabel(
                    show: true,
                    labelResolver: (_) => 'Goal: ${goalWeight!.toStringAsFixed(1)} kg',
                    alignment: Alignment.topRight,
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ])
            : ExtraLinesData(),
      ),
    );
  }
}
