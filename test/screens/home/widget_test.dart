import 'package:Noting/app/blocs/notes/notes_bloc.dart';
import 'package:Noting/app/blocs/notes/notes_event.dart';
import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/repositories/notes_repository.dart';
import 'package:Noting/app/screens/home/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockNotesRepository extends Mock implements NotesRepositoryContract {}

void main() {
  MockNotesRepository mockNotesRepository;
  List<Note> notes = List.generate(
      5,
      (i) => Note(
          id: Uuid().v4(),
          headline: 'Headline',
          content: 'Content',
          date: DateTime.now()));

  setUp(() {
    mockNotesRepository = MockNotesRepository();

    when(mockNotesRepository.getAll()).thenAnswer((_) async => notes);
  });

  tearDown(() {
    reset(mockNotesRepository);
  });
  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider<NotesBloC>(
        create: (_) =>
            NotesBloC(repository: mockNotesRepository)..add(NotesGetted()),
        child: MaterialApp(
          home: HomeScreen(),
        )));
    await tester.pumpAndSettle();

    expect(find.text(notes[0].headline), findsWidgets);
    expect(find.text(notes[0].formatedDate), findsWidgets);
  });
}
