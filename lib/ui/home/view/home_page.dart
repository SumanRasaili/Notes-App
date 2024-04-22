import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/components/custom_button.dart';
import 'package:notesapp/components/custom_textfield.dart';
import 'package:notesapp/providers/theme_provider.dart';
import 'package:notesapp/splash_screen.dart';
import 'package:notesapp/ui/auth/repository/auth_repository.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/provider/notes_prov.dart';
import 'package:notesapp/ui/home/repository/notes_repository.dart';
import 'package:notesapp/ui/home/widgets/note_list.dart';
import 'package:notesapp/utils/validation.dart';
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
              return AlertDialog(
                scrollable: true,
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                contentPadding: EdgeInsets.zero,
                content: Builder(
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                        key: formKey,
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
                            CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    var mode = NotesModel(
                                        id: uid.v4(),
                                        createdDate: DateTime.now(),
                                        title: titleController.text,
                                        description: descriptionController.text,
                                        date: DateFormat("yyyy-MM-dd")
                                            .format(DateTime.now()));
                                    ref
                                        .read(notesRepositoryProvider)
                                        .addProduct(mode, context);
                                    // print(mode.id);
                                  }
                                },
                                label: "Save"),
                          ],
                        ),
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

              StreamBuilder<List<NotesModel>>(
                stream: noteProv,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  var dd = snapshot.data ?? [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    print(snapshot.stackTrace);
                    return Center(
                      child: Text(snapshot.error.toString()),
                    ); // Handle errors
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No Data"),
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
