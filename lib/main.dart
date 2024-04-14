import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/config/color_schemes.dart';
import 'package:notesapp/core/shared_pref.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/theme_prov/theme_provider.dart';
import 'package:notesapp/ui/home/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPref.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thememode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: thememode,
      home: const HomeScreen(),
    );
  }
}
