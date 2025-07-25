import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:expensetracker/screens/privacy_policy_screen.dart';
import 'package:expensetracker/screens/statistics_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'welcome_screen.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'help_center_screen.dart';

import 'home_screen.dart';

import 'wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
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
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = FirebaseAuth.instance.currentUser;
        final name = userProvider.user?.displayName ?? "User";
        final email = user?.email ?? "No email";

        return Scaffold(
          appBar: AppBar(title: const Text("")),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 50,
                    child: const Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text("Edit Profile"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Settings"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Help Center"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpCenterScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Privacy Policy"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Logout"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 3,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: "",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            ],
            onTap: (index) {
              if (index == 3) {
                return;
              } else if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatisticsScreen(),
                  ),
                );
              } else if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WalletScreen()),
                );
              }
            },
          ),
        );
      },
    );
  }
}

void showSetLimitDialog(BuildContext context) {
  TextEditingController limitController = TextEditingController();
  var userProvider = Provider.of<UserProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Set Daily Expense Limit"),
        content: TextField(
          controller: limitController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Enter limit amount"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              double limit = double.tryParse(limitController.text) ?? 0.0;
              userProvider.setDailyLimit(limit);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}
