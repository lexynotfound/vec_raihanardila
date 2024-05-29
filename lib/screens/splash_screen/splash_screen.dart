import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../constant/images.dart';
import '../onboarding_screen/onboard_screen.dart'; // Ensure the import path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = '';
  String _appName = '';

  @override
  void initState() {
    super.initState();
    _getVersion();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreenState(),
        ),
      ),
    );
  }

  Future<void> _getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appName = packageInfo.appName;
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.green],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Logo
          Center(
            child: Image.asset(
              Images.logo,
              width: 200.0,
            ),
          ),
          // Version number
          Positioned(
            bottom: 30.0,
            right: 20.0,
            child: Text(
              'App $_appName'
              'Version $_version',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
