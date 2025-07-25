import 'package:expensetracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import 'home_screen.dart';
import 'wallet_screen.dart'; // Add this import
import 'profile_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<BarChartGroupData> _getBarChartData(TransactionProvider provider) {
    List<double> incomeData;
    List<double> expenseData;
    List<String> labels;

    if (_selectedTab == 0) {
      incomeData = provider.getWeeklyData("Income");
      expenseData = provider.getWeeklyData("Expense");
      labels = ["Wed", "Tue", "Mon", "Sun", "Sat", "Fri", "Thu"];
    } else if (_selectedTab == 1) {
      incomeData = provider.getMonthlyData("Income");
      expenseData = provider.getMonthlyData("Expense");
      labels = ["Week 1", "Week 2", "Week 3", "Week 4"];
    } else {
      incomeData = provider.getYearlyData("Income");
      expenseData = provider.getYearlyData("Expense");
      labels = ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"];
    }

    return List.generate(incomeData.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: incomeData[index] * _animation.value,
            color: ThemeProvider.accentTeal,
            width: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          BarChartRodData(
            toY: expenseData[index] * _animation.value,
            color: Colors.redAccent,
            width: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Statistics")),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTabButton("Weekly", 0),
                    _buildTabButton("Monthly", 1),
                    _buildTabButton("Yearly", 2),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 2,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barGroups: _getBarChartData(provider),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final labels = _selectedTab == 0
                                      ? [
                                          "Wed",
                                          "Tue",
                                          "Mon",
                                          "Sun",
                                          "Sat",
                                          "Fri",
                                          "Thu",
                                        ]
                                      : _selectedTab == 1
                                          ? [
                                              "Week 1",
                                              "Week 2",
                                              "Week 3",
                                              "Week 4",
                                            ]
                                          : [
                                              "J",
                                              "F",
                                              "M",
                                              "A",
                                              "M",
                                              "J",
                                              "J",
                                              "A",
                                              "S",
                                              "O",
                                              "N",
                                              "D",
                                            ];
                                  return Text(
                                    labels[value.toInt()],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(show: false),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "Transactions",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: provider.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = provider.transactions[index];
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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1, // StatisticsScreen is index 1
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
              if (index == 1) {
                // Already on StatisticsScreen, do nothing
                return;
              } else if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
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

  Widget _buildTabButton(String title, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedTab = index;
          _animationController.reset();
          _animationController.forward();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedTab == index
            ? ThemeProvider.primaryNavy
            : Colors.grey[300],
        foregroundColor: _selectedTab == index
            ? Colors.white
            : ThemeProvider.textSecondaryLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(title),
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
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
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
            Text(date, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
