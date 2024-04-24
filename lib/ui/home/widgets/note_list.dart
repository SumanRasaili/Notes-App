import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/provider/notes_prov.dart';
import 'package:notesapp/ui/home/repository/notes_repository.dart';
import 'package:notesapp/ui/home/widgets/show_dialog.dart';

class NoteListWidget extends HookConsumerWidget {
  final NotesModel note;
  const NoteListWidget({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(note.title ?? "-",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AddOrEditNotesPage(
                              descriptionController: descriptionController
                                ..text = note.description ?? "",
                              titleController: titleController
                                ..text = note.title ?? "",
                              formKey: formKey,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  var mode = NotesModel(
                                      id: note.id,
                                      createdDate: DateTime.now(),
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      date: DateFormat("yyyy-MM-dd")
                                          .format(DateTime.now()));
                                  ref
                                      .read(notesRepositoryProvider)
                                      .editProduct(mode, context)
                                      .then((value) {
                                    titleController.text = "";
                                    descriptionController.text = "";
                                  });
                                }
                              },
                            );
                          });
                    },
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(notesProvider.notifier)
                          .deleteNote(note.id ?? "");
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(note.description ?? "-",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 10,
          ),
          Text(note.date ?? "-",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
