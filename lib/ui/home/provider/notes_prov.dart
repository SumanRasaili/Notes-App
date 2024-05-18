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

  List<NotesModel> todayNotesModel = [];

  getNotesList() {
    final notes = ref.read(notesRepositoryProvider).getNotesList();
    state = notes;
  }

  getTodayNotesList() {
    var todayYear = DateTime.now().year;
    var month = DateTime.now().month;
    var day = DateTime.now().day;
    var notestream = state;
    notestream.listen((event) {
      todayNotesModel = event
          .where((element) =>
              element.createdDate?.year == todayYear &&
              element.createdDate?.day == day &&
              element.createdDate?.month == month)
          .toList();
      print("The today Notes is ${todayNotesModel.first.title}");
    });
  }

  deleteNote(String id) {
    ref.read(notesRepositoryProvider).deleteProduct(id: id);
  }
}
