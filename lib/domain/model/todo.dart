import 'package:intl/intl.dart';

class Todo {
  final String title;
  final String description;
  final bool isCompleted;
  final int timestampInMillisecondsFromEpoch;

  Todo({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.timestampInMillisecondsFromEpoch,
  });


  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestampInMillisecondsFromEpoch);
  String get formattedDate => DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

  Todo copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    int? timestampInMillisecondsFromEpoch,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      timestampInMillisecondsFromEpoch: timestampInMillisecondsFromEpoch == -1 ? DateTime.now().millisecondsSinceEpoch : this.timestampInMillisecondsFromEpoch
    );
  }
}