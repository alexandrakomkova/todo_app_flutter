import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/todo.dart';
import '../bloc/add_todo_bloc/add_todo_bloc.dart';
import '../bloc/todo_bloc/todo_bloc.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();

  // final _titleController = TextEditingController();
  // final _descriptionController = TextEditingController();
  //
  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _descriptionController.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddTodoBloc>().state;
    final status = context.select((AddTodoBloc bloc) => bloc.state.status);

    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Form(
            key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // close button
                  const Align(
                    alignment: Alignment.topRight,
                    child: CloseButton(),
                  ),

                  // dialog title
                  const Center(
                    child: Text(
                      "Add Task",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12.0),
                  // task title text field
                  TextFormField(
                    key: const Key('addTodoDialog_title_textFormField'),
                    initialValue: state.title,
                    //controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please enter task title';
                      }

                      return null;
                    },
                    maxLength: 20,
                    onChanged: (value) {
                      context.read<AddTodoBloc>().add(OnTodoTitleChanged(value));
                    },
                  ),
                  const SizedBox(height: 12.0),

                  // task description text field
                  TextFormField(
                   // controller: _descriptionController,
                    key: const Key('addTodoDialog_description_textFormField'),
                    initialValue: state.description,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    maxLength: 200,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                    ),
                    onChanged: (value) {
                      context.read<AddTodoBloc>().add(OnTodoDescriptionChanged(value));
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // save in db
                        //print('${_titleController.text} ${_descriptionController.text}');

                        // status.isLoadingOrSuccess
                        //     ? null
                        //     : () => context.read<AddTodoBloc>().add(const OnTodoSave());
                        //

                        // status.isLoadingOrSuccess
                        //     ? print(status.toString())
                        //     : () => context.read<AddTodoBloc>().add(const OnTodoSave());

                        context.read<AddTodoBloc>().add(const OnTodoSave());

                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                          'Save',
                      ),
                    ),
                  ),
                ),
                  const SizedBox(height: 2.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
