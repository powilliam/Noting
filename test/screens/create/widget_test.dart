import 'package:Noting/app/screens/create/controller.dart';
import 'package:Noting/app/screens/create/widget.dart';
import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCreateScreenController extends Mock
    implements CreateScreenControllerContract {}

void main() {
  MockCreateScreenController mockCreateScreenController;
  TextEditingController headlineTextEditingController;
  TextEditingController contentTextEditingController;

  setUp(() {
    mockCreateScreenController = MockCreateScreenController();
    headlineTextEditingController = TextEditingController();
    contentTextEditingController = TextEditingController();

    when(mockCreateScreenController.headlineTextEditingController)
        .thenReturn(headlineTextEditingController);
    when(mockCreateScreenController.contentTextEditingController)
        .thenReturn(contentTextEditingController);
  });

  tearDown(() {
    reset(mockCreateScreenController);
  });

  tearDownAll(() {
    headlineTextEditingController.dispose();
    contentTextEditingController.dispose();
  });

  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CreateScreen(controller: mockCreateScreenController),
    ));

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(2));
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.text('Headline'), findsOneWidget);
    expect(find.text('Write what you have in mind'), findsOneWidget);
  });

  testWidgets('Should be able to fill all texts fields',
      (WidgetTester tester) async {
    final String headline = "It's the headline";
    final String content = "It's the content";

    await tester.pumpWidget(MaterialApp(
      home: CreateScreen(controller: mockCreateScreenController),
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
