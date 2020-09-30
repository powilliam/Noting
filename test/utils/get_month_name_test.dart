import 'package:Noting/app/utils/get_month_name.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should be able to return the right month name', () {
    expect(getMonthName(1), 'January');
    expect(getMonthName(9), 'September');
    expect(getMonthName(12), 'December');
  });
}
