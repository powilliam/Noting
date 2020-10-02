import 'dart:async';

import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/providers/notes_provider.dart';

abstract class NotesRepositoryContract {
  Future<List<Note>> getAll();
  Future<Note> create(Note note);
  Future<String> update(String id, Note note);
  Future<String> delete(String id);
}

class NotesRepository implements NotesRepositoryContract {
  NotesRepository({this.provider}) : assert(provider != null);

  final NotesProviderContract provider;

  @override
  Future<List<Note>> getAll() async {
    try {
      final List<Map<String, dynamic>> notes = await provider.getAll();
      return List.generate(
          notes.length,
          (i) => Note(
                id: notes[i]['id'],
                headline: notes[i]['headline'],
                content: notes[i]['content'],
                date: DateTime.fromMillisecondsSinceEpoch(notes[i]['date']),
              ));
    } catch (e) {
      throw Exception('Cannot get values{}');
    }
  }

  @override
  Future<Note> create(Note note) async {
    try {
      await provider.create(note.toJSON());
      return note;
    } catch (e) {
      throw Exception('Cannot create data{note: $note}');
    }
  }

  @override
  Future<String> update(String id, Note note) async {
    try {
      await provider.update(id, note.toJSON());
      return id;
    } catch (e) {
      throw Exception('Cannot update data{id: $id, note: $note}');
    }
  }

  @override
  Future<String> delete(String id) async {
    try {
      await provider.delete(id);
      return id;
    } catch (e) {
      throw Exception('Cannot delete data{id: $id}');
    }
  }
}
