import 'package:Noting/app/utils/get_month_name.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  Note({this.id, this.headline, this.date, this.content})
      : assert(id != null),
        assert(headline != null),
        assert(content != null),
        assert(date != null);

  final String id;
  final String headline;
  final String content;
  final DateTime date;

  String get formatedDate =>
      "${getMonthName(date.month)} ${date.day}, ${date.year}";

  Map<String, dynamic> toJSON() => {
        'id': id,
        'headline': headline,
        'content': content,
        'date': date.millisecondsSinceEpoch,
      };

  @override
  List<Object> get props => [id, headline, content, date];

  @override
  bool get stringify => true;
}
