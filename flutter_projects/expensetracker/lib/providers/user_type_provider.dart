import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTypeProvider with ChangeNotifier {
  String _userType = "House Maker"; // Default user type

  String get userType => _userType;

  UserTypeProvider() {
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    final prefs = await SharedPreferences.getInstance();
    _userType = prefs.getString('userType') ?? "House Maker";
    notifyListeners();
  }

  Future<void> setUserType(String userType) async {
    _userType = userType;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);
    notifyListeners();
  }
}
