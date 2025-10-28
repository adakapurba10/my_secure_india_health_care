import 'package:flutter/material.dart';
import 'firebase/firebase_init.dart';
import 'dashboard/customer_dashboard.dart';
import 'dashboard/retailer_dashboard.dart';
import 'dashboard/wholesaler_dashboard.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Secure India Health Care',
      routes: {
        '/customer': (_) => const CustomerDashboard(),
        '/retailer': (_) => const RetailerDashboard(),
        '/wholesaler': (_) => const WholesalerDashboard(),
      },
      home: const LoginScreen(),
    );
  }
}
