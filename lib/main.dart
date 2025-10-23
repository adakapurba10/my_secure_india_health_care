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
      home: Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Center(child: Text('Firebase Initialized')),
      ),
    );
  }
}
