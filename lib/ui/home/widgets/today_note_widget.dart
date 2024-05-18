import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/config/asset_paths.dart';
import 'package:notesapp/ui/home/model/note_models.dart';
import 'package:notesapp/ui/home/provider/notes_prov.dart';
import 'package:notesapp/ui/home/widgets/note_list.dart';

class TodayNotesWidget extends ConsumerWidget {
  const TodayNotesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteProv = ref.watch(notesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<List<NotesModel>>(
          stream: noteProv,
          builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
            var dd = snapshot.data ?? [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: const Center(
                      child: CircularProgressIndicator.adaptive()));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              ); // Handle errors
            } else if (dd.isEmpty) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 200,
                          width: 250,
                          AssetPaths.noDataFound,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Uh Hoooo..",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Please add some Plans for today ..",
                          style: TextStyle(fontSize: 16),
                        )
                      ]),
                ),
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
        ),
      ],
    );
  }
}
