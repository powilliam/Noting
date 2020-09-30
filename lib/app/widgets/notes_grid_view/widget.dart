import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/screens/note/widget.dart';
import 'package:Noting/app/widgets/single_note/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesGridView extends StatelessWidget {
  final Note note = Note(
      id: '0',
      headline: 'How to use BloC',
      date: DateTime.now(),
      content: "It's so easy if you know Flux Architecture");

  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;

    return Scrollbar(
        thickness: 3.0,
        child: StaggeredGridView.countBuilder(
          itemCount: 12,
          crossAxisCount: 2,
          itemBuilder: (_, i) => SingleNote(
            key: Key(i.toString()),
            margin: (i == 1) ? EdgeInsets.only(top: 40) : null,
            color:
                (i == 0 || i % 3 == 0) ? Color(0xFF726A95) : Color(0xFF212121),
            title: note.headline,
            date: note.formatedDate,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteScreen(note: note)));
            },
          ),
          staggeredTileBuilder: (i) => StaggeredTile.fit(1),
          padding: EdgeInsets.only(
              top: insets.top + 21, left: 21, right: 21, bottom: 80),
          mainAxisSpacing: 17,
          crossAxisSpacing: 17,
        ));
  }
}
