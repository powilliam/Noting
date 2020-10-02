import 'package:Noting/app/app.dart';
import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/repositories/notes_repository.dart';
import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockNotesRepository extends Mock implements NotesRepositoryContract {}

void main() {
  MockNotesRepository mockNotesRepository;
  List<Note> notes = List.generate(
      5,
      (_) => Note(
          id: Uuid().v4(),
          headline: 'It is the headline',
          content: 'It is the content',
          date: DateTime.now()));

  setUp(() {
    mockNotesRepository = MockNotesRepository();

    when(mockNotesRepository.getAll()).thenAnswer((_) async => notes);
  });

  tearDown(() {
    reset(mockNotesRepository);
  });

  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(App(repository: mockNotesRepository));
    await tester.pumpAndSettle();

    expect(find.text(notes[0].headline), findsWidgets);
    expect(find.text(notes[0].formatedDate), findsWidgets);
    expect(find.byWidgetPredicate((widget) => widget is FloatingActionButton),
        findsOneWidget);
  });

  testWidgets('Should be able to navigate to Note Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(App(repository: mockNotesRepository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key(notes[0].id)));
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(3));
    expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.text(notes[0].headline), findsOneWidget);
    expect(find.text(notes[0].formatedDate), findsOneWidget);
    expect(find.text(notes[0].content), findsOneWidget);
  });

  testWidgets('Should be able to navigate to Create Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(App(repository: mockNotesRepository));
    await tester.pumpAndSettle();

    await tester.tap(
        find.byWidgetPredicate((widget) => widget is FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(2));
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.text('Headline'), findsOneWidget);
    expect(find.text('Write what you have in mind'), findsOneWidget);
  });

  testWidgets('Should be able to navigate to Update Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(App(repository: mockNotesRepository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key(notes[0].id)));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(2));
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.text(notes[0].headline), findsOneWidget);
    expect(find.text(notes[0].content), findsOneWidget);
  });
}
