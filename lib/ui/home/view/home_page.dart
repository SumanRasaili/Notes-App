import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/config/asset_paths.dart';
import 'package:notesapp/providers/theme_provider.dart';
import 'package:notesapp/ui/auth/repository/auth_repository.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/provider/notes_prov.dart';
import 'package:notesapp/ui/home/repository/notes_repository.dart';
import 'package:notesapp/ui/home/widgets/note_list.dart';
import 'package:notesapp/ui/home/widgets/show_dialog.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final timeController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final thememodes = ref.watch(themeProvider);
    var uid = const Uuid();
    final noteProv = ref.watch(notesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddOrEditNotesPage(
                  descriptionController: descriptionController,
                  titleController: titleController,
                  formKey: formKey,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var mode = NotesModel(
                          id: uid.v4(),
                          createdDate: DateTime.now(),
                          title: titleController.text,
                          description: descriptionController.text,
                          date:
                              DateFormat("yyyy-MM-dd").format(DateTime.now()));
                      ref
                          .read(notesRepositoryProvider)
                          .addProduct(mode, context)
                          .then((value) {
                        titleController.text = "";
                        descriptionController.text = "";
                      });
                    }
                  },
                );
              });
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
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                          content: const Text("Do you really want to LogOut?"),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text("No"),
                            ),
                            FilledButton(
                              onPressed: () async {
                                await ref
                                    .read(authProvider)
                                    .signOutUser(ctx, ref);
                              },
                              child: const Text("YES"),
                            ),
                          ],
                          title: const Text("Log Out"));
                    });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<NotesModel>>(
                stream: noteProv,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  var dd = snapshot.data ?? [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: const Center(
                            child: CircularProgressIndicator.adaptive()));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    ); // Handle errors
                  } else if (snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              (kToolbarHeight)) /
                          1.3,
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetPaths.noDataFound,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Uh Hoooo..",
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Please add some Plans..",
                                style: TextStyle(fontSize: 16),
                              )
                            ]),
                      ),
                    ); // Handle the case when there's no data
                  } else {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NoteListWidget(
                            note: dd[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: dd.length);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
