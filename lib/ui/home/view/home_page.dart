import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/components/custom_button.dart';
import 'package:notesapp/components/custom_textfield.dart';
import 'package:notesapp/splash_screen.dart';
import 'package:notesapp/theme_prov/theme_provider.dart';
import 'package:notesapp/ui/auth/repository/auth_repository.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/widgets/note_list.dart';
import 'package:notesapp/utils/validation.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final timeController = useTextEditingController();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 120),
                contentPadding: EdgeInsets.zero,
                content: Builder(
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          CustomTextField(
                            showRequired: true,
                            controller: titleController,
                            labelText: "Title",
                            validator: (p0) => Validators.isRequired(p0),
                            hintText: "Enter title here",
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomTextField(
                            showRequired: true,
                            controller: descriptionController,
                            labelText: "Description",
                            maxLines: 4,
                            validator: (p0) => Validators.isRequired(p0),
                            hintText: "Enter description here",
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomButton(onPressed: () {}, label: "Save"),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
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
                  : const Icon(Icons.dark_mode)),
          IconButton(
              onPressed: () {
                ref.read(authProvider).signOutUser().then((value) =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SplashScreen())));
              },
              icon: const Icon(Icons.logout))
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
