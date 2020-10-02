import 'package:Noting/app/models/note.dart';
import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NotesGetted extends NotesEvent {
  @override
  String toString() => "NotesGetted{}";
}

class NotesCreated extends NotesEvent {
  NotesCreated([this.note]) : assert(note != null);

  final Note note;

  @override
  List<Object> get props => [note];

  @override
  String toString() => "NotesCreated{note: $note}";
}

class NotesUpdated extends NotesEvent {
  NotesUpdated([this.id, this.note])
      : assert(id != null),
        assert(note != null);

  final String id;
  final Note note;

  @override
  List<Object> get props => [id, note];

  @override
  String toString() => "NotesUpdated{id: $id, note: $note}";
}

class NotesDeleted extends NotesEvent {
  NotesDeleted([this.id]) : assert(id != null);

  final String id;

  @override
  List<Object> get props => [id];

  @override
  String toString() => "NotesDeleted{id: $id}";
}
