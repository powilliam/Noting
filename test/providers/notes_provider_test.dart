import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/providers/notes_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockNotesProvider extends Mock implements NotesProviderContract {}

void main() {
  MockNotesProvider mockNotesProvider;
  List<Map<String, dynamic>> listOfNotes;

  setUp(() {
    mockNotesProvider = MockNotesProvider();
    listOfNotes = List.generate(
        3,
        (_) => Note(
                id: Uuid().v4(),
                headline: 'Headline',
                content: 'Content',
                date: DateTime.now())
            .toJSON());

    when(mockNotesProvider.getAll()).thenAnswer((_) async => listOfNotes);
    when(mockNotesProvider.create(any))
        .thenAnswer((invocation) async => invocation.positionalArguments[0]);
    when(mockNotesProvider.update(any, any))
        .thenAnswer((invocation) async => invocation.positionalArguments[0]);
    when(mockNotesProvider.delete(any))
        .thenAnswer((invocation) async => invocation.positionalArguments[0]);
  });

  tearDown(() {
    reset(mockNotesProvider);
  });

  test('Should be able to list all notes', () async {
    expect(await mockNotesProvider.getAll(), listOfNotes);
  });

  test('Should be able to create a note', () async {
    expect(await mockNotesProvider.create(listOfNotes[0]), listOfNotes[0]);
  });

  test('Should be able to update a note', () async {
    expect(await mockNotesProvider.update(listOfNotes[0]['id'], listOfNotes[1]),
        listOfNotes[0]['id']);
  });

  test('Should be able to delete a note', () async {
    expect(await mockNotesProvider.delete(listOfNotes[0]['id']),
        listOfNotes[0]['id']);
  });
}
