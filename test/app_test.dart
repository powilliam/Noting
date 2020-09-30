import 'package:Noting/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('Hello World'), findsOneWidget);
  });
}
