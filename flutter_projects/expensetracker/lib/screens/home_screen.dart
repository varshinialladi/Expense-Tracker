import 'package:expensetracker/providers/theme_provider.dart';
// import 'package:expensetracker/screens/qr_scanner_screen.dart';
import 'package:expensetracker/screens/statistics_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';
import 'add_transaction_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
    return Consumer2<TransactionProvider, UserProvider>(
      builder: (context, transactionProvider, userProvider, child) {
        final user = FirebaseAuth.instance.currentUser;
        final name = user?.displayName ?? 'User';
        final transactions = transactionProvider.transactions
            .where(
              (transaction) =>
                  transaction.category.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ) ||
                  transaction.description.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ),
            )
            .toList();

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello,",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                  ),
                                  Text(
                                    name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(width: 135),
                              IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  showSearchDialog(context);
                                },
                              ),
                              Container(
                                child: GestureDetector(
                                  // onTap: () {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => QRScannerScreen(),
                                  //     ),
                                  //   );
                                  // },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.qr_code_scanner,
                                        color: Color.fromARGB(255, 15, 40, 38),
                                        size: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Scan Bill",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Total Balance",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "\$${transactionProvider.totalBalance.toStringAsFixed(2)}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge?.copyWith(
                                          color: transactionProvider
                                                      .totalBalance >=
                                                  0
                                              ? const Color.fromARGB(
                                                  255,
                                                  255,
                                                  254,
                                                  254,
                                                )
                                              : Colors.redAccent,
                                        ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_downward,
                                                color: const Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "Income",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "\$${transactionProvider.totalIncome.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: const Color.fromARGB(
                                                255,
                                                249,
                                                240,
                                                240,
                                              ),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.arrow_upward,
                                                color: Color.fromARGB(
                                                  255,
                                                  151,
                                                  11,
                                                  11,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "Expense",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "\$${transactionProvider.totalExpense.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Recent Transactions",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: transactions.isEmpty
                                ? Center(
                                    child: Text(
                                      "No transactions found",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: transactions.length,
                                    itemBuilder: (context, index) {
                                      final transaction = transactions[index];
                                      return TransactionTile(
                                        icon: transaction.icon,
                                        color: transaction.color,
                                        title: transaction.category,
                                        subtitle: transaction.description,
                                        amount: transaction.type == "Income"
                                            ? "+\$${transaction.amount.toStringAsFixed(2)}"
                                            : "-\$${transaction.amount.toStringAsFixed(2)}",
                                        date:
                                            "${transaction.date.day} ${getMonthName(transaction.date.month)}",
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransactionScreen(),
                ),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: ThemeProvider.accentTeal,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
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
              if (index == 0) {
                return;
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
              } else if (index == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Search Transactions"),
          content: TextField(
            decoration: const InputDecoration(
              hintText: "Search by category or description",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                });
                Navigator.pop(context);
              },
              child: const Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  String getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}

class TransactionTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String amount;
  final String date;

  const TransactionTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                color: amount.startsWith("+")
                    ? ThemeProvider.accentTeal
                    : Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(date, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
