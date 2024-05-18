import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/providers/theme_provider.dart';
import 'package:notesapp/ui/auth/repository/auth_repository.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/repository/notes_repository.dart';
import 'package:notesapp/ui/home/widgets/show_dialog.dart';
import 'package:notesapp/ui/home/widgets/today_note_widget.dart';
import 'package:notesapp/ui/home/widgets/yesterday_note_widget.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final timeController = useState<DateTime>(DateTime.now());
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final thememodes = ref.watch(themeProvider);
    var uid = const Uuid();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddOrEditNotesPage(
                  dateTime: timeController.value,
                  descriptionController: descriptionController,
                  titleController: titleController,
                  formKey: formKey,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var mode = NotesModel(
                        id: uid.v4(),
                        createdDate: DateTime.now(),
                        title: titleController.text,
                        date: timeController.value,
                        description: descriptionController.text,
                      );
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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodayNotesWidget(),
              SizedBox(
                height: 15,
              ),
              YesterdayNotesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
