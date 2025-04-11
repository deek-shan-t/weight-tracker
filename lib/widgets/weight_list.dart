import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightList extends StatelessWidget {
  final List<Map<String, dynamic>> weights;

  WeightList({required this.weights});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: weights.length,
      itemBuilder: (context, index) {
        final entry = weights[index];
        final date = DateTime.parse(entry['date']);
        final formattedDate = DateFormat.yMMMd().format(date);

        return ListTile(
          title: Text('${entry['weight']} kg'),
          subtitle: Text(formattedDate),
        );
      },
    );
  }
}
