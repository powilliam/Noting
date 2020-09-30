import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should be able to render with normal type',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: NotingButton(child: Icon(Icons.add)),
        ),
      ),
    ));

    expect(
        find.byWidgetPredicate((widget) =>
            widget is NotingButton && widget.type == NotingButtonType.NORMAL),
        findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Should be able to render with outline type',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: NotingButton(
            child: Icon(Icons.add),
            type: NotingButtonType.OUTLINE,
          ),
        ),
      ),
    ));

    expect(
        find.byWidgetPredicate((widget) =>
            widget is NotingButton && widget.type == NotingButtonType.OUTLINE),
        findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Should be able to tap', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: NotingButton(
            child: Icon(Icons.add),
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    ));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(tapped, true);
  });
}
