import 'package:Noting/app/app.dart';
import 'package:Noting/app/providers/notes_provider.dart';
import 'package:Noting/app/repositories/notes_repository.dart';
import 'package:flutter/material.dart';

void main() => runApp(App(
      repository: NotesRepository(provider: NotesProvider()),
    ));
