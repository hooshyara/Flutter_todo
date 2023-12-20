import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  final String text;
  bool is_done;

  Task({
    required this.title,
    required this.text,
    required this.is_done,
  }) : id = Uuid().v4();
}
