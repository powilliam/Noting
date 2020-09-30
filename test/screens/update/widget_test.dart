import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/screens/update/widget.dart';
import 'package:Noting/app/screens/update/controller.dart';
import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUpdateScreenController extends Mock
    implements UpdateScreenControllerContract {}

void main() {
  MockUpdateScreenController mockUpdateScreenController;
  TextEditingController headlineTextEditingController;
  TextEditingController contentTextEditingController;
  final Note note = Note(
      id: '0',
      headline: 'Inherited Headline',
      date: DateTime.now(),
      content: 'Inherited Content');

  setUp(() {
    mockUpdateScreenController = MockUpdateScreenController();
    headlineTextEditingController = TextEditingController();
    contentTextEditingController = TextEditingController();

    when(mockUpdateScreenController.headlineTextEditingController)
        .thenReturn(headlineTextEditingController);
    when(mockUpdateScreenController.contentTextEditingController)
        .thenReturn(contentTextEditingController);
  });

  tearDown(() {
    reset(mockUpdateScreenController);
  });

  tearDownAll(() {
    headlineTextEditingController.dispose();
    contentTextEditingController.dispose();
  });

  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: UpdateScreen(controller: mockUpdateScreenController, note: note),
    ));

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(2));
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.text(note.headline), findsOneWidget);
    expect(find.text(note.content), findsOneWidget);
  });

  testWidgets('Should be able to fill all texts fields',
      (WidgetTester tester) async {
    final String headline = "It's the headline";
    final String content = "It's the content";

    await tester.pumpWidget(MaterialApp(
      home: UpdateScreen(controller: mockUpdateScreenController, note: note),
    ));

    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextField && widget.decoration.hintText == 'Headline'),
        headline);
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextField &&
            widget.decoration.hintText == 'Write what you have in mind'),
        content);
    await tester.pumpAndSettle();

    expect(headlineTextEditingController.text, headline);
    expect(contentTextEditingController.text, content);
    expect(find.text(headline), findsOneWidget);
    expect(find.text(content), findsOneWidget);
  });
}
