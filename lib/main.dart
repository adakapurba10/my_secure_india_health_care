import 'package:flutter/material.dart';
import 'firebase/firebase_init.dart';
import 'dashboard/customer_dashboard.dart';
import 'dashboard/retailer_dashboard.dart';
import 'dashboard/wholesaler_dashboard.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Secure India Health Care',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/customer': (_) => const CustomerDashboard(),
        '/retailer': (_) => const RetailerDashboard(),
        '/wholesaler': (_) => const WholesalerDashboard(),
      },
      home: const LoginScreen(),
    );
  }
}
