import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/repository/notes_repository.dart';

final notesProvider =
    StateNotifierProvider.autoDispose<NotesNotifier, Stream<List<NotesModel>>>(
        (ref) {
  return NotesNotifier(ref: ref);
});

class NotesNotifier extends StateNotifier<Stream<List<NotesModel>>> {
  NotesNotifier({required this.ref}) : super(const Stream.empty()) {
    getNotesList();
  }
  Ref ref;

  getNotesList() {
    final notes = ref.read(notesRepositoryProvider).getTodayNotesList();
    state = notes;
  }

  deleteNote({required String id,required BuildContext context}) {
    ref.read(notesRepositoryProvider).deleteProduct(id: id,context: context);
  }
}
