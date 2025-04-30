import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _goalWeightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  double? _goalWeight;
  String? _name;
  double? _height;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goalWeight = prefs.getDouble('goalWeight');
      _height = prefs.getDouble('height');
      _name = prefs.getString('name');
      _goalWeightController.text = _goalWeight?.toString() ?? _goalWeightController.text;
      if (_height != null) {
        _heightController.text = _height.toString();
      }
      if (_name != null) {
        _nameController.text = _name!;
      }
    });
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final double? parsedWeight = double.tryParse(_goalWeightController.text);
    final double? parsedHeight = double.tryParse(_heightController.text);
    final String name = _nameController.text;

    if (parsedWeight != null && parsedHeight != null && name.isNotEmpty) {
      await prefs.setDouble('goalWeight', parsedWeight);
      await prefs.setDouble('height', parsedHeight);
      await prefs.setString('name', name);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile data saved')),
      );
    }
  }

  // Sign-in with Google
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('googleEmail', googleUser.email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed in as ${googleUser.email}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $error')),
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
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _goalWeightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Goal Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUserData,
              child: Text('Save Profile'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
