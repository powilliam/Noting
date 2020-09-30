import 'package:Noting/app/app.dart';
import 'package:Noting/app/utils/get_month_name.dart';
import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DateTime now = DateTime.now();
  final String date = "${getMonthName(now.month)} ${now.day}, ${now.year}";
  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('How to use BloC'), findsWidgets);
    expect(find.text(date), findsWidgets);
    expect(find.byWidgetPredicate((widget) => widget is FloatingActionButton),
        findsOneWidget);
  });

  testWidgets('Should be able to navigate to Note Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(App());

    await tester.tap(find.byKey(Key('0')));
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(3));
    expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.text('How to use BloC'), findsOneWidget);
    expect(find.text(date), findsOneWidget);
    expect(find.text("It's so easy if you know Flux Architecture"),
        findsOneWidget);
  });

  testWidgets('Should be able to navigate to Create Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(App());

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
    await tester.pumpWidget(App());

    await tester.tap(find.byKey(Key('0')));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NotingButton),
        findsNWidgets(2));
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.text('How to use BloC'), findsOneWidget);
    expect(find.text("It's so easy if you know Flux Architecture"),
        findsOneWidget);
  });
}
