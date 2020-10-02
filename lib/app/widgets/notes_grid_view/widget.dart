import 'package:Noting/app/blocs/notes/notes_bloc.dart';
import 'package:Noting/app/blocs/notes/notes_state.dart';
import 'package:Noting/app/screens/note/widget.dart';
import 'package:Noting/app/widgets/single_note/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;

    return Scrollbar(
        thickness: 3.0,
        child: BlocBuilder<NotesBloC, NotesState>(
            builder: (context, state) => StaggeredGridView.countBuilder(
                  itemCount: state.notes.length,
                  crossAxisCount: 2,
                  itemBuilder: (_, i) => SingleNote(
                    key: Key(state.notes[i].id),
                    margin: (i == 1) ? EdgeInsets.only(top: 40) : null,
                    color: (i == 0 || i % 3 == 0)
                        ? Color(0xFF726A95)
                        : Color(0xFF212121),
                    title: state.notes[i].headline,
                    date: state.notes[i].formatedDate,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              NoteScreen(note: state.notes[i])));
                    },
                  ),
                  staggeredTileBuilder: (i) => StaggeredTile.fit(1),
                  padding: EdgeInsets.only(
                      top: insets.top + 21, left: 21, right: 21, bottom: 80),
                  mainAxisSpacing: 17,
                  crossAxisSpacing: 17,
                )));
  }
}
