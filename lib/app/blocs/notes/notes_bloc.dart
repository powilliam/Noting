import 'package:Noting/app/blocs/notes/notes_event.dart';
import 'package:Noting/app/blocs/notes/notes_state.dart';
import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/repositories/notes_repository.dart';
import 'package:bloc/bloc.dart';

class NotesBloC extends Bloc<NotesEvent, NotesState> {
  NotesBloC({this.repository})
      : assert(repository != null),
        super(NotesStateInitial());

  final NotesRepositoryContract repository;

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    yield* _mapStateToLoadInProgress();
    if (event is NotesGetted) {
      yield* _mapNotesGettedToState(event);
    }
    if (event is NotesCreated) {
      yield* _mapNotesCreatedToState(event);
    }
    if (event is NotesUpdated) {
      yield* _mapNotesUpdatedToState(event);
    }
    if (event is NotesDeleted) {
      yield* _mapNotesDeletedToState(event);
    }
  }

  Stream<NotesStateLoadInProgress> _mapStateToLoadInProgress() async* {
    yield NotesStateLoadInProgress(state.notes);
  }

  Stream<NotesState> _mapNotesGettedToState(NotesGetted event) async* {
    try {
      final List<Note> notes = await repository.getAll();
      yield NotesStateSuccess(notes);
    } catch (e) {
      yield NotesStateFailure(state.notes);
    }
  }

  Stream<NotesState> _mapNotesCreatedToState(NotesCreated event) async* {
    try {
      await repository.create(event.note);
      final List<Note> notes = await repository.getAll();
      yield NotesStateSuccess(notes);
    } catch (e) {
      yield NotesStateFailure(state.notes);
    }
  }

  Stream<NotesState> _mapNotesUpdatedToState(NotesUpdated event) async* {
    try {
      await repository.update(event.id, event.note);
      final List<Note> notes = await repository.getAll();
      yield NotesStateSuccess(notes);
    } catch (e) {
      yield NotesStateFailure(state.notes);
    }
  }

  Stream<NotesState> _mapNotesDeletedToState(NotesDeleted event) async* {
    try {
      await repository.delete(event.id);
      final List<Note> notes = await repository.getAll();
      yield NotesStateSuccess(notes);
    } catch (e) {
      yield NotesStateFailure(state.notes);
    }
  }
}
