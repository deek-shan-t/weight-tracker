import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _goalWeightController = TextEditingController();
  double? _goalWeight;

  @override
  void initState() {
    super.initState();
    _loadGoalWeight();
  }

  Future<void> _loadGoalWeight() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goalWeight = prefs.getDouble('goalWeight');
      if (_goalWeight != null) {
        _goalWeightController.text = _goalWeight.toString();
      }
    });
  }

  Future<void> _saveGoalWeight() async {
    final prefs = await SharedPreferences.getInstance();
    final double? parsedWeight = double.tryParse(_goalWeightController.text);
    if (parsedWeight != null) {
      await prefs.setDouble('goalWeight', parsedWeight);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Goal weight saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _goalWeightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Goal Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveGoalWeight,
              child: Text('Save Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
