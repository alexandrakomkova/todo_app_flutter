

import 'package:hive_ce/hive.dart';
import 'package:todo_app/domain/model/todo.dart';

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  int get typeId => 0;

  @override
  Todo read(BinaryReader reader) {
    return Todo(
        title: reader.read(),
        description: reader.read(),
        isCompleted: reader.read(),
        timestampInMillisecondsFromEpoch: reader.read(),
    );
  }
  
  @override
  void write(BinaryWriter writer, Todo todo) {
    writer.write(todo.title);
    writer.write(todo.description);
    writer.write(todo.isCompleted);
    writer.write(todo.timestampInMillisecondsFromEpoch);
  }
  
}

