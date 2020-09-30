import 'package:Noting/app/utils/get_month_name.dart';

class Note {
  Note({this.id, this.headline, this.date, this.content})
      : assert(id != null),
        assert(headline != null),
        assert(date != null),
        assert(content != null);

  final String id;
  final String headline;
  final DateTime date;
  final String content;

  String get formatedDate =>
      "${getMonthName(date.month)} ${date.day}, ${date.year}";
}
