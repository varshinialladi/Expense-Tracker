import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _currentTheme;

  ThemeProvider() : _currentTheme = _lightTheme {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;
  ThemeData get currentTheme => _currentTheme;

  static const Color primaryNavy = Color(0xFF203A43); // Navy Blue
  static const Color secondaryGold = Color(0xFF0F2027); // Gold
  static const Color accentTeal = Color.fromARGB(255, 0, 0, 0); // Soft Teal
  static const Color backgroundLight = Color(0xFFF5F6FA); // Off-White
  static const Color backgroundDark = Color(0xFF121212); // Dark Gray
  static const Color cardLight = Color(0xFFFFFFFF); // White
  static const Color cardDark = Color(0xFF1E1E1E); // Dark Gray
  static const Color textPrimaryLight = Color(0xFF1A2A44); // Navy Blue
  static const Color textSecondaryLight = Color(0xFF666666); // Gray
  static const Color textPrimaryDark = Colors.white; // White
  static const Color textSecondaryDark = Color(0xFFB0B0B0); // Light Gray

  // Light Theme
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryNavy,
    scaffoldBackgroundColor: backgroundLight,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 33, 38, 35),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimaryLight,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.grey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    // cardTheme: CardTheme(
    //   color: const Color(0xFF203A43),
    //   elevation: 4,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(15)),
    //     side: BorderSide(color: secondaryGold.withOpacity(0.1)),
    //   ),
    // ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(255, 228, 240, 240).withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondaryGold, width: 1.5),
      ),
      prefixIconColor: primaryNavy,
      hintStyle: const TextStyle(color: textSecondaryLight),
    ),
    iconTheme: const IconThemeData(color: primaryNavy),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: secondaryGold,
      unselectedItemColor: textSecondaryLight,
      backgroundColor: cardLight,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundLight,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textPrimaryLight),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryGold,
      foregroundColor: primaryNavy,
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
  );

  // Dark Theme
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryNavy,
    scaffoldBackgroundColor: backgroundDark,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      bodyMedium: TextStyle(fontSize: 16, color: textSecondaryDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: primaryNavy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    // cardTheme: CardTheme(
    //   color: cardDark,
    //   elevation: 4,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(15)),
    //     side: BorderSide(color: secondaryGold.withOpacity(0.3)),
    //   ),
    // ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: accentTeal.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondaryGold, width: 1.5),
      ),
      prefixIconColor: secondaryGold,
      hintStyle: const TextStyle(color: textSecondaryDark),
    ),
    iconTheme: const IconThemeData(color: secondaryGold),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: textSecondaryDark,
      backgroundColor: cardDark,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundDark,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: textPrimaryDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textPrimaryDark),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryGold,
      foregroundColor: primaryNavy,
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: MaterialStateProperty.all(
        const Color.fromARGB(255, 254, 250, 250),
      ),
    ),
  );

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _currentTheme = _isDarkMode ? _darkTheme : _lightTheme;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    _currentTheme = _isDarkMode ? _darkTheme : _lightTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
