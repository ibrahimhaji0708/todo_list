import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
//import 'package:todo_list/cubit/todo_cubit.dart';
import 'package:todo_list/models/todo_model.dart';

class AddTodoPage extends StatefulWidget {
  final Todo? todo;

  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final todoTitleController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      todoTitleController.text = widget.todo!.name;
      isEditing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(isEditing ? 'Edit Todo' : 'Add Todo'),
        // Back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: todoTitleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _GradientButton(
                    onPressed: () {
                      //context.read<TodoBloc>().add(AddTodoEvent());
                      // In the relevant widget:
                      context.read<TodoBloc>().add(AddTodoEvent(Todo(
                          name: todoTitleController.text.trim(),
                          id: UniqueKey().toString(),
                          completed: false)));

                      if (isEditing) {
                        BlocProvider.of<TodoBloc>(context).updateTodo(
                          widget.todo!.id,
                          todoTitleController.text.trim(),
                        );
                        // } else if (controller.text.isNotEmpty) {
                        //   context
                        //       .read<TodoBloc>()
                        //       .add(UpdateTodoEvent(todo.name, controller.text));

                        //   Navigator.pop(context);
                      } else {
                        BlocProvider.of<TodoBloc>(context).addTodo(
                          todoTitleController.text.trim(),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(isEditing ? 'Save' : 'Add'),
                  ),
                  if (isEditing)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        BlocProvider.of<TodoBloc>(context)
                            .deleteTodo(widget.todo!.id);
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const _GradientButton({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        // Gradient effect
        overlayColor: MaterialStateProperty.all<Color>(
          Colors.deepPurple.withOpacity(0.4),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}