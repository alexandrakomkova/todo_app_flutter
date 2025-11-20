import 'package:intl/intl.dart';

class Todo {
  final String title;
  final String description;
  final bool isCompleted;
  final int creationTimestamp;

  const Todo({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.creationTimestamp,
  });

  String get id => creationTimestamp.toString();

  DateTime get creationTimestampDateTime => DateTime.fromMillisecondsSinceEpoch(creationTimestamp);
  String get formattedCreationTimestamp => DateFormat('yyyy-MM-dd HH:mm').format(creationTimestampDateTime);

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
      creationTimestamp: timestampInMillisecondsFromEpoch ?? this.creationTimestamp
    );
  }
}