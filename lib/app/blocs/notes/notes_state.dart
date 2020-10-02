import 'package:Noting/app/models/note.dart';
import 'package:equatable/equatable.dart';

abstract class NotesState extends Equatable {
  NotesState([this.notes = const []]);

  final List<Note> notes;

  @override
  List<Object> get props => [notes];
}

class NotesStateInitial extends NotesState {
  @override
  String toString() => "NotesStateInitial{}";
}

class NotesStateLoadInProgress extends NotesState {
  NotesStateLoadInProgress([this.notes])
      : assert(notes != null),
        super(notes);

  final List<Note> notes;

  @override
  List<Object> get props => [notes];

  @override
  String toString() => "NotesStateLoadInProgress{notes: $notes}";
}

class NotesStateSuccess extends NotesState {
  NotesStateSuccess([this.notes])
      : assert(notes != null),
        super(notes);

  final List<Note> notes;

  @override
  List<Object> get props => [notes];

  @override
  String toString() => "NotesStateSuccess{notes: $notes}";
}

class NotesStateFailure extends NotesState {
  NotesStateFailure([this.notes])
      : assert(notes != null),
        super(notes);

  final List<Note> notes;

  @override
  List<Object> get props => [notes];

  @override
  String toString() => "NotesStateFailure{notes: $notes}";
}
