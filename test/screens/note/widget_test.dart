import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/screens/note/widget.dart';
import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should be able to render', (WidgetTester tester) async {
    final Note note = Note(
        id: '0',
        headline: 'How to use BloC',
        date: DateTime.now(),
        content: "It's so easy if you know Flux Architecture");

    await tester.pumpWidget(MaterialApp(
      home: NoteScreen(note: note),
    ));

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(3));
    expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.text(note.headline), findsOneWidget);
    expect(find.text(note.formatedDate), findsOneWidget);
    expect(find.text(note.content), findsOneWidget);
  });
}
