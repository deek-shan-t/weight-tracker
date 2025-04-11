import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/weight_chart.dart';
import '../widgets/weight_list.dart';
import '../widgets/weight_entry_modal.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _weightController = TextEditingController();
  List<Map<String, dynamic>> _weights = [];

  @override
  void initState() {
    super.initState();
    _loadWeights();
  }

  void _loadWeights() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedWeights = prefs.getString('weights');
    if (storedWeights != null) {
      setState(() {
        _weights = List<Map<String, dynamic>>.from(jsonDecode(storedWeights));
      });
    }
  }

  void _saveWeights() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weights', jsonEncode(_weights));
  }

  void _saveWeight() {
    final String weightText = _weightController.text;
    if (weightText.isEmpty) return;

    final double? weight = double.tryParse(weightText);
    if (weight == null) return;

    setState(() {
      _weights.add({
        'weight': weight,
        'date': DateTime.now().toString(),
      });
    });

    _saveWeights();
    _weightController.clear();
    Navigator.pop(context);
  }

  void _showWeightEntryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => WeightEntryModal(
        controller: _weightController,
        onSave: _saveWeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Weight Tracker'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(child: WeightChart(weights: _weights)),
          Expanded(child: WeightList(weights: _weights)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showWeightEntryModal,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
