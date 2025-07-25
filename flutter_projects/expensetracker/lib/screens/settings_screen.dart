import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_type_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  bool _notificationsEnabled = true;
  String _currency = "USD";
  String _language = "English"; // Added language variable
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, UserTypeProvider>(
      builder: (context, themeProvider, userTypeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text("Settings"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView(
                children: [
                  SwitchListTile(
                    title: const Text("Notifications"),
                    subtitle: const Text("Enable or disable notifications"),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    secondary: const Icon(Icons.notifications),
                  ),
                  SwitchListTile(
                    title: const Text("Dark Mode"),
                    subtitle: const Text("Switch between light and dark theme"),
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                    },
                    secondary: const Icon(Icons.dark_mode),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: ThemeProvider.accentTeal,
                    ),
                    title: const Text("User Type"),
                    subtitle: Text("Selected: ${userTypeProvider.userType}"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Select User Type"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text("House Maker"),
                                  onTap: () {
                                    userTypeProvider.setUserType("House Maker");
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("Student"),
                                  onTap: () {
                                    userTypeProvider.setUserType("Student");
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("Office Worker"),
                                  onTap: () {
                                    userTypeProvider.setUserType(
                                      "Office Worker",
                                    );
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.currency_exchange),
                    title: const Text("Currency"),
                    subtitle: Text("Selected: $_currency"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Select Currency"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text("USD"),
                                  onTap: () {
                                    setState(() {
                                      _currency = "USD";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("EUR"),
                                  onTap: () {
                                    setState(() {
                                      _currency = "EUR";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("GBP"),
                                  onTap: () {
                                    setState(() {
                                      _currency = "GBP";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text("Language"),
                    subtitle: Text(
                      "Selected: $_language",
                    ), // Display selected language
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Select Language"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text("English"),
                                  onTap: () {
                                    setState(() {
                                      _language = "English";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("Telugu"),
                                  onTap: () {
                                    setState(() {
                                      _language = "Telugu";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text("Hindi"),
                                  onTap: () {
                                    setState(() {
                                      _language = "Hindi";
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
