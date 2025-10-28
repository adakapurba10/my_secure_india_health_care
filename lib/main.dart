import 'package:flutter/material.dart';
import 'firebase/firebase_init.dart';
import 'dashboard/customer_dashboard.dart';
import 'dashboard/retailer_dashboard.dart';
import 'dashboard/wholesaler_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Connected App',
      routes: {
        '/customer': (_) => const CustomerDashboard(),
        '/retailer': (_) => const RetailerDashboard(),
        '/wholesaler': (_) => const WholesalerDashboard(),
      },
      home: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: const Center(child: Text('Firebase Initialized')),
      ),
    );
  }
}
