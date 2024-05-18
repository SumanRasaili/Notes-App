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
    print("Note dattime ${note.date}");
    final dateTimeController = useState<DateTime>(note.date!);
    print("after Assigning ${dateTimeController.value}");
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
                              dateTime: dateTimeController.value,
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
                                      date: dateTimeController.value);
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
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                                content:
                                    const Text("Do you really want to Delete?"),
                                actions: [
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("No"),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      ref
                                          .read(notesProvider.notifier)
                                          .deleteNote(
                                              id: note.id ?? "", context: ctx);
                                    },
                                    child: const Text("YES"),
                                  ),
                                ],
                                title: const Text("Delete"));
                          });
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
          Text(DateFormat().format(note.date!),
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
