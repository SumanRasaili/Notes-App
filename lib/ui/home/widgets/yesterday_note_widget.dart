import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/repository/notes_repository.dart';
import 'package:notesapp/ui/home/widgets/note_list.dart';

class YesterdayNotesWidget extends ConsumerWidget {
  const YesterdayNotesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<NotesModel>>(
      stream: ref.read(notesRepositoryProvider).getYesterdayNotesList(),
      builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
        var dd = snapshot.data ?? [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              child: const Center(child: CircularProgressIndicator.adaptive()));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          ); // Handle errors
        } else if (snapshot.data!.isEmpty) {
          return const SizedBox(
              // height:
              //     (MediaQuery.of(context).size.height - (kToolbarHeight)) / 1.3,
              // child: Center(ch)

              );
          //     child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Image.asset(
          //             AssetPaths.noDataFound,
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           const Text(
          //             "Uh Hoooo..",
          //             style: TextStyle(fontSize: 14),
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //           const Text(
          //             "Please add some Plans..",
          //             style: TextStyle(fontSize: 16),
          //           )
          //         ]),
          //   ),
          // ); // Handle the case when there's no data
        } else {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Yesterday",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    // reverse: true,
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
                    itemCount: dd.length),
              ]);
        }
      },
    );
  }
}
