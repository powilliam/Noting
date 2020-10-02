import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/providers/notes_provider.dart';
import 'package:Noting/app/repositories/notes_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockNotesProvider extends Mock implements NotesProviderContract {}

void main() {
  MockNotesProvider mockNotesProvider;
  NotesRepository notesRepository;
  List<Map<String, dynamic>> listOfNotesInMap;

  setUp(() {
    listOfNotesInMap = List.generate(
        3,
        (_) => ({
              'id': Uuid().v4(),
              'headline': 'Headline',
              'content': 'Content',
              'date': DateTime.now().millisecondsSinceEpoch
            }));

    mockNotesProvider = MockNotesProvider();
    notesRepository = NotesRepository(provider: mockNotesProvider);

    when(mockNotesProvider.getAll()).thenAnswer((_) async => listOfNotesInMap);
    when(mockNotesProvider.create(any)).thenAnswer(
        (implementation) async => implementation.positionalArguments[0]);
    when(mockNotesProvider.update(any, any)).thenAnswer(
        (implementation) async => implementation.positionalArguments[0]);
    when(mockNotesProvider.delete(any)).thenAnswer(
        (implementation) async => implementation.positionalArguments[0]);
  });

  tearDown(() {
    reset(mockNotesProvider);
  });

  test('Should be able to get all notes', () async {
    expect(await notesRepository.getAll(), isNotEmpty);
  });

  test('Should be able to create a note', () async {
    final Note note = Note(
        id: listOfNotesInMap[0]['id'],
        headline: listOfNotesInMap[0]['headline'],
        content: listOfNotesInMap[0]['content'],
        date: DateTime.fromMillisecondsSinceEpoch(listOfNotesInMap[0]['date']));

    expect(await notesRepository.create(note), note);
  });

  test('Should be able to update a note', () async {
    final Note note = Note(
        id: listOfNotesInMap[0]['id'],
        headline: 'Updated headline',
        content: 'Updated content',
        date: DateTime.fromMillisecondsSinceEpoch(listOfNotesInMap[0]['date']));

    expect(await notesRepository.update(note.id, note), note.id);
  });

  test('Should be able to delete a note', () async {
    expect(await notesRepository.delete(listOfNotesInMap[0]['id']),
        listOfNotesInMap[0]['id']);
  });
}
