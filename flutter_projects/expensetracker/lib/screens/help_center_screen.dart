import 'package:expensetracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Help Center"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.question_answer,
                  color: ThemeProvider.accentTeal,
                ),
                title: const Text("FAQs"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("FAQs"),
                        content: const Text(
                          "Q: How do I add a transaction?\nA: Go to the Home screen and tap the '+' button.\n\n"
                          "Q: How do I change my user type?\nA: Go to Settings and select 'User Type'.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.support_agent,
                  color: ThemeProvider.accentTeal,
                ),
                title: const Text("Contact Support"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Contact support at support@financeapp.com",
                      ),
                    ),
                  );
                },
              ),
              const ListTile(
                leading: Icon(Icons.info, color: ThemeProvider.accentTeal),
                title: Text("App Version"),
                subtitle: Text("1.0.0"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
