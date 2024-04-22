import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/provider/notes_prov.dart';
import 'package:notesapp/ui/home/repository/notes_repository.dart';

class NoteListWidget extends HookConsumerWidget {
  final NotesModel note;
  const NoteListWidget({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              GestureDetector(
                onTap: () {
                  ref.read(notesProvider.notifier).deleteNote(note.id ?? "");
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
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
          Text(note.timeStamp ?? "-",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
