import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/ui/auth/screens/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>  LoginScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Note App",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
            SizedBox(
              height: 60,
            ),
            LinearProgressIndicator()
          ],
        ),
      ),
    );
  }
}
