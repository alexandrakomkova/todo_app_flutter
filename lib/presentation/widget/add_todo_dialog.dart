import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _titleController,
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
                  ),
                  const SizedBox(height: 12.0),

                  // task description text field
                  TextFormField(
                    controller: _descriptionController,
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
                  ),
                  const SizedBox(height: 20.0),

                  // save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // save in db
                        print('${_titleController.text} ${_descriptionController.text}');
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
