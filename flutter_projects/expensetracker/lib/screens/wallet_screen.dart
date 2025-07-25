import 'package:expensetracker/screens/statistics_screens.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallets")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Wallets",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Color.fromARGB(255, 208, 194, 194),
                ),
                title: const Text(
                  "Wallet 1",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: const Text(
                  "Default Wallet",
                  style: TextStyle(color: Color.fromARGB(255, 208, 194, 194)),
                ),
                trailing: const Text(
                  "\$1500.00",
                  style: TextStyle(
                    color: Color.fromARGB(255, 208, 194, 194),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Color.fromARGB(255, 208, 194, 194),
                ),
                title: const Text(
                  "Wallet 2",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: const Text(
                  "Savings Wallet",
                  style: TextStyle(color: Color.fromARGB(255, 208, 194, 194)),
                ),
                trailing: const Text(
                  "\$500.00",
                  style: TextStyle(
                    color: Color.fromARGB(255, 208, 194, 194),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Add Wallet feature coming soon!"),
                    ),
                  );
                },
                child: const Text("Add New Wallet"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // WalletScreen is index 2
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
          if (index == 2) {
            // Already on WalletScreen, do nothing
            return;
          } else if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StatisticsScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
