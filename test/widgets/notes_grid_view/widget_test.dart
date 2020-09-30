import 'package:Noting/app/utils/get_month_name.dart';
import 'package:Noting/app/widgets/notes_grid_view/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DateTime now = DateTime.now();
  final String date = "${getMonthName(now.month)} ${now.day}, ${now.year}";
  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: NotesGridView())));

    expect(find.text('How to use BloC'), findsWidgets);
    expect(find.text(date), findsWidgets);
  });
}
