// lib/providers/limit_provider.dart

import 'package:flutter/material.dart';

class LimitProvider with ChangeNotifier {
  double _dailyLimit = 0.0;

  double get dailyLimit => _dailyLimit;

  void setDailyLimit(double limit) {
    _dailyLimit = limit;
    notifyListeners();
  }
}
