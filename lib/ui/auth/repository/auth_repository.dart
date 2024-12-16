import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/components/custom_bot_toast.dart';
import 'package:notesapp/ui/auth/screens/login_screen.dart';
import 'package:notesapp/ui/home/view/home_page.dart';

final authProvider = Provider<AuthRepository>((ref) {
  print("Auth prov called");
  return AuthRepository();
});

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get user => _firebaseAuth.authStateChanges();
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      CustomBotToast.loading();
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        BotToast.closeAllLoading();
        CustomBotToast.text(
          "User Logged In Successfully",
          isSuccess: true,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      print("Error is  $e");
      BotToast.closeAllLoading();
      CustomBotToast.text(
        e.toString(),
        isSuccess: false,
      );
    }
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      CustomBotToast.loading();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        BotToast.closeAllLoading();
        CustomBotToast.text(
          "User Registered Successfully",
          isSuccess: true,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      });
    } on FirebaseAuthException catch (e) {
      BotToast.closeAllLoading();
      CustomBotToast.text(
        e.toString(),
        isSuccess: false,
      );
    }
  }

  Future<void> signOutUser(BuildContext ctx, WidgetRef ref) async {
    CustomBotToast.loading();
    try {
      await _firebaseAuth.signOut().then((value) {
        BotToast.closeAllLoading();
        CustomBotToast.text("Signed Out Successfully", isSuccess: true);
        Phoenix.rebirth(ctx);
        // Navigator.of(ctx).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (ctx) => const SplashScreen()),
        //   (route) => false,
        // );
      });
    } on FirebaseAuthException catch (e) {
      print("The error is $e");
      print("The error is ${e.stackTrace}");
      BotToast.closeAllLoading();
      CustomBotToast.text(
        e.toString(),
        isSuccess: false,
      );
    }
  }
}
