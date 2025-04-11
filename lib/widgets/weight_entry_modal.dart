import 'package:flutter/material.dart';

class WeightEntryModal extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  WeightEntryModal({required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter Weight',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter your weight (kg)',
              hintStyle: TextStyle(color: Colors.white54),
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[800],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: onSave,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
