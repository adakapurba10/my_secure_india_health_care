import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // অ্যানিমেশন কন্ট্রোলার সেটআপ
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bool useBiometric = await _authService.canAuthenticateBiometric();
      if (useBiometric) {
        bool authenticated = await _authService.authenticateBiometric();
        if (!authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometric authentication failed')),
          );
          return;
        }
      }

      final user = await _authService.signInWithGoogle();
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'name': user.displayName,
          'role': 'customer', // ডিফল্ট রোল, পরে লজিক দিয়ে কাস্টমাইজ করা যাবে
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // ইউজারের রোল চেক করে সঠিক রাউটে নিয়ে যান
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final role = userDoc['role'] ?? 'customer';
        if (role == 'retailer') {
          Navigator.pushReplacementNamed(context, '/retailer');
        } else if (role == 'wholesaler') {
          Navigator.pushReplacementNamed(context, '/wholesaler');
        } else {
          Navigator.pushReplacementNamed(context, '/customer');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4CAF50), // হেলথকেয়ার-থিমযুক্ত সবুজ
              Color(0xFF2196F3), // নীল গ্রেডিয়েন্ট
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // লোগো
                    Image.asset(
                      'assets/logo.png',
                      height: 150,
                      width: 150,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.local_hospital,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // অ্যাপের নাম
                    const Text(
                      'My Secure India Health Care',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // সাবটাইটেল
                    const Text(
                      'Your trusted healthcare partner',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 40),
                    // Google Sign-In বাটন
                    ElevatedButton.icon(
                      onPressed: () => _signInWithGoogle(context),
                      icon: const Icon(Icons.login, color: Colors.white),
                      label: const Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // লোডিং ইন্ডিকেটর (ঐচ্ছিক)
                    ValueListenableBuilder<bool>(
                      valueListenable: ValueNotifier<bool>(false),
                      builder: (context, isLoading, child) {
                        return isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
