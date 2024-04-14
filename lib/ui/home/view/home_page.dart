import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/theme_prov/theme_provider.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/widgets/note_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thememodes = ref.watch(themeProvider);
    List notes = [
      NotesModel(
          title: "Food",
          description: "I have to eat food",
          timeStamp: "2024-04-14"),
      NotesModel(
          title: "Food",
          description: "I have to eat food",
          timeStamp: "2024-04-13"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        title: const Text(
          "My Notes",
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: thememodes == ThemeMode.dark
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // TitleRow(
              //   name: "Today",
              //   onPressed: () {},
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NoteListWidget(
                      note: notes[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: notes.length)
            ],
          ),
        ),
      ),
    );
  }
}
