import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_type_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen>
    with SingleTickerProviderStateMixin {
  String? selectedType = "Expense";
  String? selectedWallet;
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final Map<String, Map<String, dynamic>> categoryIcons = {
    "Income": {
      "icon": Icons.attach_money,
      "color": const Color.fromARGB(255, 217, 207, 207),
    },
    "Food": {"icon": Icons.fastfood, "color": Colors.orange},
    "Travel": {"icon": Icons.directions_car, "color": Colors.blue},
    "Electricity": {
      "icon": Icons.electrical_services,
      "color": Colors.yellow[800],
    },
    "Bills": {"icon": Icons.receipt, "color": Colors.red},
    "Shopping": {"icon": Icons.shopping_cart, "color": Colors.purple},
    "Clothing": {"icon": Icons.checkroom, "color": Colors.purple},
    "Health": {"icon": Icons.favorite, "color": Colors.redAccent},
    "Education": {"icon": Icons.school, "color": Colors.green},
    "Entertainment": {"icon": Icons.movie, "color": Colors.cyan},
    "Work Expenses": {"icon": Icons.work, "color": Colors.grey},
    "Groceries": {
      "icon": Icons.local_grocery_store,
      "color": Colors.green[300],
    },
    "Household": {"icon": Icons.home, "color": Colors.brown},
  };

  final Map<String, List<String>> userTypeCategories = {
    "House Maker": [
      "Food",
      "Electricity",
      "Bills",
      "Shopping",
      "Clothing",
      "Health",
      "Groceries",
      "Household",
      "Entertainment",
    ],
    "Student": [
      "Food",
      "Travel",
      "Education",
      "Shopping",
      "Clothing",
      "Health",
      "Entertainment",
    ],
    "Office Worker": [
      "Food",
      "Travel",
      "Bills",
      "Shopping",
      "Clothing",
      "Health",
      "Work Expenses",
      "Entertainment",
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submitTransaction(BuildContext context) {
    if (selectedCategory == null || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
      return;
    }

    final amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    final transaction = Transaction(
      id: DateTime.now().toString(),
      type: selectedType!,
      category: selectedCategory!,
      description: descriptionController.text,
      amount: amount,
      date: selectedDate,
      icon: categoryIcons[selectedCategory]!["icon"],
      color: categoryIcons[selectedCategory]!["color"],
    );

    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).addTransaction(transaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<UserTypeProvider>(context).userType;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Type", style: Theme.of(context).textTheme.bodyMedium),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: const InputDecoration(),
                  items: ["Income", "Expense"]
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                      selectedCategory = null;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text("Wallet", style: Theme.of(context).textTheme.bodyMedium),
                DropdownButtonFormField<String>(
                  value: selectedWallet,
                  decoration: const InputDecoration(),
                  hint: const Text("Select wallet"),
                  items: ["Wallet 1", "Wallet 2"]
                      .map(
                        (wallet) => DropdownMenuItem(
                          value: wallet,
                          child: Text(wallet),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedWallet = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text("Category", style: Theme.of(context).textTheme.bodyMedium),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(),
                  hint: const Text("Select category"),
                  items: (selectedType == "Income"
                          ? ["Income"]
                          : userTypeCategories[userType]!)
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text("Date", style: Theme.of(context).textTheme.bodyMedium),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Amount", style: Theme.of(context).textTheme.bodyMedium),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 20),
                Text(
                  "Description (optional)",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _submitTransaction(context),
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
