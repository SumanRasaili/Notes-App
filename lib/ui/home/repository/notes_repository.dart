import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/components/custom_bot_toast.dart';
import 'package:notesapp/config/constants.dart';
import 'package:notesapp/providers/firebase_providers.dart';
import 'package:notesapp/ui/home/model/note_models.dart';

final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  return NotesRepository(firestore: ref.read(firebaseFirestoreProvider));
});

class NotesRepository {
  late FirebaseFirestore _firestore;
  NotesRepository({required FirebaseFirestore firestore}) {
    _firestore = firestore;
  }

  Future<void> addProduct(NotesModel model, BuildContext context) async {
    final notesjson = {
      "title": model.title,
      "description": model.description,
      "date": model.timeStamp,
    };
    CustomBotToast.loading();
    try {
      await _firestore
          .collection(AppConstants.notesCollection)
          .doc()
          .set(notesjson)
          .then((value) {
        CustomBotToast.text("Added Successfully", isSuccess: true);
        Navigator.pop(context);
      });
    } on FirebaseException catch (e) {
      BotToast.closeAllLoading();
      CustomBotToast.text(e.message.toString(), isSuccess: false);
    }
  }

  Stream<List<NotesModel>> getNotesList() async* {
    try {
      yield* _firestore
          .collection(AppConstants.notesCollection)
          .snapshots()
          .map((event) {
        print("Event is $event");
        List<NotesModel> allNotes = [];
        for (var doc in event.docs) {
          allNotes.add(NotesModel.fromJson(doc.data()));
        }
        for (var element in allNotes) {
          print("Desc is ${element.description}");
        }
        print("All Notes is $allNotes");
        // return event.docs
        //     .map((doc) => NotesModel.fromJson(doc.data()))
        //     .toList();
        return allNotes;
      });
    } on FirebaseException catch (e) {
      BotToast.closeAllLoading();
      CustomBotToast.text(e.message.toString(), isSuccess: false);
    }
  }
}
