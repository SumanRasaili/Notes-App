import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/ui/home/model/note_models.dart';

final notesProvider =
    StateNotifierProvider<NotesNotifier, List<NotesModel>>((ref) {
  return NotesNotifier();
});

class NotesNotifier extends StateNotifier<List<NotesModel>> {
  NotesNotifier() : super([]);
}
