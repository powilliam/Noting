import 'package:Noting/app/blocs/notes/notes_bloc.dart';
import 'package:Noting/app/blocs/notes/notes_event.dart';
import 'package:Noting/app/blocs/notes/notes_state.dart';
import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/repositories/notes_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockNotesRepository extends Mock implements NotesRepositoryContract {}

void main() {
  MockNotesRepository mockNotesRepository;
  NotesBloC notesBloC;
  List<Note> notes = List.generate(
      5,
      (i) => Note(
          id: Uuid().v4(),
          headline: 'Headline',
          content: 'Content',
          date: DateTime.now()));

  setUp(() {
    mockNotesRepository = MockNotesRepository();
    notesBloC = NotesBloC(repository: mockNotesRepository);

    when(mockNotesRepository.getAll()).thenAnswer((_) async => notes);
    when(mockNotesRepository.create(any)).thenAnswer((implementation) async {
      notes.add(implementation.positionalArguments[0]);
      return implementation.positionalArguments[0];
    });
    when(mockNotesRepository.update(any, any))
        .thenAnswer((implementation) async {
      final String id = implementation.positionalArguments[0];
      final Note updatedNote = implementation.positionalArguments[1];
      final int noteIndex = notes.indexWhere((note) => note.id == id);
      notes
        ..removeAt(noteIndex)
        ..insert(noteIndex, updatedNote);
      return id;
    });
    when(mockNotesRepository.delete(any)).thenAnswer((implementation) async {
      final String id = implementation.positionalArguments[0];
      final int noteIndex = notes.indexWhere((note) => note.id == id);
      notes.removeAt(noteIndex);
      return id;
    });
  });

  tearDown(() {
    reset(mockNotesRepository);
  });

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateSuccess] when event is NotesGetted',
      build: () => notesBloC,
      act: (bloc) {
        bloc.add(NotesGetted());
      },
      expect: [NotesStateLoadInProgress([]), NotesStateSuccess(notes)]);

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateFailure] when event is NotesGetted',
      build: () => notesBloC,
      act: (bloc) {
        when(mockNotesRepository.getAll()).thenThrow(Exception());
        bloc.add(NotesGetted());
      },
      expect: [NotesStateLoadInProgress([]), NotesStateFailure([])]);

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateSuccess] when event is NotesCreated',
      build: () => notesBloC,
      act: (bloc) {
        bloc.add(NotesCreated(notes[0]));
      },
      expect: [NotesStateLoadInProgress([]), NotesStateSuccess(notes)]);

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateFailure] when event is NotesCreated',
      build: () => notesBloC,
      act: (bloc) {
        when(mockNotesRepository.create(any)).thenThrow(Exception());
        bloc.add(NotesCreated(notes[0]));
      },
      expect: [NotesStateLoadInProgress([]), NotesStateFailure([])]);

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateSuccess] when event is NotesUpdated',
      build: () => notesBloC,
      act: (bloc) {
        bloc.add(NotesUpdated(notes[0].id, notes[1]));
      },
      expect: [NotesStateLoadInProgress([]), NotesStateSuccess(notes)]);

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateFailure] when event is NotesUpdated',
      build: () => notesBloC,
      act: (bloc) {
        when(mockNotesRepository.update(any, any)).thenThrow(Exception());
        bloc.add(NotesUpdated(notes[0].id, notes[1]));
      },
      expect: [NotesStateLoadInProgress([]), NotesStateFailure([])]);

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateSuccess] when event is NotesDeleted',
      build: () => notesBloC,
      act: (bloc) {
        bloc.add(NotesDeleted(notes[0].id));
      },
      expect: [NotesStateLoadInProgress([]), NotesStateSuccess(notes)]);

  blocTest<NotesBloC, NotesState>(
      'Should be able to emit [NotesStateLoadInProgress, NotesStateFailure] when event is NotesDeleted',
      build: () => notesBloC,
      act: (bloc) {
        when(mockNotesRepository.delete(any)).thenThrow(Exception());
        bloc.add(NotesDeleted(notes[0].id));
      },
      expect: [NotesStateLoadInProgress([]), NotesStateFailure([])]);
}
