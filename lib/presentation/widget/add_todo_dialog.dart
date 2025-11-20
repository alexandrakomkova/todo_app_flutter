import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/l10n/l10n.dart';

import '/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';

class AddTodoDialog extends StatefulWidget {

  const AddTodoDialog({
    super.key
  });

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddTodoBloc>().state;
    final l10n = context.l10n;

    return BlocListener<AddTodoBloc, AddTodoState>(
          listenWhen: (previous, current) =>
            previous.status != current.status &&
                current.status == AddTodoStatus.success,
          listener: (context, state) => Navigator.of(context).pop(),
      child: Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
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
                  Center(
                    child: Text(
                      state.isNewTodo ? l10n.addTodoDialogTitleAddMode : l10n.addTodoDialogTitleEditMode,
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
                    decoration: InputDecoration(
                      hintText: l10n.addTodoDialogTodoTitleField,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      errorStyle: TextStyle(fontSize: 11.0)
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return l10n.addTodoDialogTodoTitleFieldEmptyError;
                      }

                      return null;
                    },
                    maxLength: 20,
                    onChanged: (value) {
                      context.read<AddTodoBloc>().add(OnTodoTitleChanged(value));
                    },
                  ),
                  const SizedBox(height: 15.0),

                  // task description text field
                  TextFormField(
                    key: const Key('addTodoDialog_description_textFormField'),
                    initialValue: state.description,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    maxLength: 200,
                    decoration: InputDecoration(
                      hintText: l10n.addTodoDialogTodoDescriptionField,
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
                        context.read<AddTodoBloc>().add(const OnTodoSave());
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          l10n.addTodoDialogTodoSaveButton,
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
      ),
    );
  }
}
