import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/theme_prov/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thememodes = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HomeScreen",
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: thememodes==ThemeMode.dark ? const Icon(Icons.light_mode):const Icon(Icons.dark_mode))
        ],
      ),
    );
  }
}
