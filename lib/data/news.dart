import 'package:meta/meta.dart';

class News {
  News({
    @required this.cover,
    @required this.title,
    @required this.content,
    @required this.createAt,
  });

  DateTime createAt;
  String cover;
  String title;
  String content;
}
