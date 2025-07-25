import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'providers/transaction_provider.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_type_provider.dart';
import 'providers/limit_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserTypeProvider()),
        ChangeNotifierProvider(create: (_) => LimitProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Finance App',
            theme: themeProvider.currentTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

class FirestoreTestPage extends StatelessWidget {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await users.add({
              'name': 'Test User',
              'timestamp': FieldValue.serverTimestamp(),
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Data Added!')),
            );
          },
          child: Text('Add to Firestore'),
        ),
      ),
    );
  }
}
