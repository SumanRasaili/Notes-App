import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/config/color_schemes.dart';
import 'package:notesapp/core/fcm_service.dart';
import 'package:notesapp/core/shared_pref.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/providers/theme_provider.dart';
import 'package:notesapp/splash_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingService().initMessaging();
  await SharedPref.init();
  runApp(ProviderScope(
      observers: [Logger()], child: Phoenix(child: const MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thememode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      builder: BotToastInit(),
      darkTheme: darkTheme,
      navigatorObservers: [BotToastNavigatorObserver()],
      themeMode: thememode,
      home: const SplashScreen(),
    );
  }
}
