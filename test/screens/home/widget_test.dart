import 'package:Noting/app/screens/home/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
    ));

    expect(find.text('Hello World'), findsOneWidget);
  });
}
