import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/ui/auth/repository/auth_repository.dart';
import 'package:notesapp/ui/auth/screens/login_screen.dart';
import 'package:notesapp/ui/home/view/home_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(authProvider).user.listen((User? user) {
      if (user == null) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        } else {
          print("unmounted");
        }
      } else {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          print("yoyoyo unmounted");
        }
      }
    });
    // Future.delayed(const Duration(seconds: 2))
    //     .then((value) => Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(
    //             builder: (cc) => const LoginScreen(),
    //           ),
    //         ));
    // initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: ref.read(authProvider).user,
        builder: (context, snapshot) {
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
        });
  }
}
