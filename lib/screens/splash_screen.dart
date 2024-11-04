import 'package:bd_app/screens/onboarding_screens/onboarding.dart';
import 'package:bd_app/widgets/custom_background.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const Onboarding();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomBackground(),
            Center(
              child: Image(
                image: AssetImage('images/Metaviz Logo SVG1 1.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
