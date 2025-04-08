import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodPredictionPage extends StatefulWidget {
  static const routeName = '/FoodPredictionPage';

  @override
  _FoodPredictionPageState createState() => _FoodPredictionPageState();
}

class _FoodPredictionPageState extends State<FoodPredictionPage> {
  final TextEditingController _barcodeController = TextEditingController();
  String? _result = "";
  bool _isLoading = false;

  Future<void> _predictFoodLabel() async {
    final code = _barcodeController.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isLoading = true;
      _result = "";
    });

    final url = Uri.parse(
        'http://192.168.43.127/predict'); // ← Remplace X.X par ton IP locale
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"code": code});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          _result = "${json['description']} (Label: ${json['label']})";
        });
      } else {
        final json = jsonDecode(response.body);
        setState(() {
          _result = "Erreur: ${json['error']}";
        });
      }
    } catch (e) {
      setState(() {
        _result = "Erreur de connexion : $e";
      });
      log("Erreur : $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Label Checker')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: 'Enter barcode',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictFoodLabel,
              child: Text('Predict'),
            ),
            SizedBox(height: 20),
            if (_isLoading) CircularProgressIndicator(),
            if (_result != null && _result!.isNotEmpty)
              Text(
                _result!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
