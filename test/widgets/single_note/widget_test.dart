import 'package:Noting/app/utils/get_month_name.dart';
import 'package:Noting/app/widgets/single_note/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DateTime now = DateTime.now();
  final String date = "${getMonthName(now.month)} ${now.day}, ${now.year}";

  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          body: Center(
        child: SingleNote(
          title: 'How to use BloC',
          date: date,
        ),
      )),
    ));

    expect(find.text('How to use BloC'), findsOneWidget);
    expect(find.text(date), findsOneWidget);
  });

  testWidgets('Should be able to tap', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: SingleNote(
          title: '',
          date: '',
          onTap: () {
            tapped = true;
          },
        ),
      ),
    ));

    await tester.tap(find.byWidgetPredicate((widget) => widget is SingleNote));
    await tester.pumpAndSettle();

    expect(tapped, true);
  });
}
