import 'package:Noting/app/blocs/notes/notes_bloc.dart';
import 'package:Noting/app/blocs/notes/notes_event.dart';
import 'package:Noting/app/repositories/notes_repository.dart';
import 'package:Noting/app/screens/home/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Use pushAndRemoveUntil to ensure that the navigator state was reseted
//TODO: Implements form validation with Snackbar as alert for Create Screen and Update Screen
class App extends StatelessWidget {
  static const String _title = "Noting";

  App({@required this.repository}) : assert(repository != null);

  final NotesRepositoryContract repository;

  @override
  Widget build(BuildContext context) => BlocProvider<NotesBloC>(
      create: (_) => NotesBloC(repository: repository)..add(NotesGetted()),
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
            primaryColor: Color(0xFF212121), accentColor: Color(0xFF212121)),
        home: HomeScreen(),
      ));
}
