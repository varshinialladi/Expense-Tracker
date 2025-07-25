import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class GenerateQRScreen extends StatelessWidget {
  final Map<String, dynamic> transaction = {
    "type": "Expense",
    "category": "Food",
    "description": "Dinner at restaurant",
    "amount": "25.00",
    "date": DateTime.now().toIso8601String(),
  };

  @override
  Widget build(BuildContext context) {
    String qrData = jsonEncode(transaction); // Convert transaction to JSON

    return Scaffold(
      appBar: AppBar(title: const Text("Generate QR Code")),
      body: Center(
        child: QrImageView(
          data: qrData, // QR code data
          size: 200, // QR code size
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
