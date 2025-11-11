import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widget/add_todo_dialog.dart';
import 'package:todo_app/presentation/widget/todo_card.dart';

import '../domain/model/todo.dart';

var todoList = [
  Todo(title: 'hw', description: 'eng p 123 ex 3, 4', isCompleted: true, timestampInMillisecondsFromEpoch: DateTime.now().millisecondsSinceEpoch),
  Todo(title: 'make dinner', description: 'buy some milkkkkkkkkkkkkkkkkkkkkkkkk1', isCompleted: false, timestampInMillisecondsFromEpoch: DateTime.now().millisecondsSinceEpoch)
];

// var todoList = [];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddTodoDialog()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTodoDialog(context);
          },
          child: Icon(
              Icons.add
          ),
        ),
        body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      var todo = todoList[index];

                      return TodoCard(todo: todo);
                    },
                  )
              ),*/

             /* Text(
                '''Click "+" to add your first task!''',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),*/

              todoList.isEmpty ? _emptyTodoList() : _todoList()
            ],
          ),
      ),
    )
    );
  }
}

Widget _todoList() {
  return Expanded(
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          var todo = todoList[index];

          return TodoCard(todo: todo);
        },
      )
  );
}

Widget _emptyTodoList() {
  return Text(
      '''Click "+" to add your first task!''',
      style: TextStyle(
        fontSize: 18,
      ),
  );
}


