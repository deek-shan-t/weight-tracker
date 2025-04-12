import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightList extends StatelessWidget {
  final List<Map<String, dynamic>> weights;
  final void Function(int) onDelete;

  WeightList({required this.weights, required this.onDelete});

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
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(index),
          ),
        );
      },
    );
  }
}
