import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            final todos = state.todos;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Dismissible(
                  key: Key(todo.id),
                  background: Container(
                    color: Colors.red,
                  ),
                  confirmToDelete: true,
                  onDismissed: (direction) {
                    BlocProvider.of<TodoBloc>(context)
                        .add(DeleteTodoEvent(todo.id));
                  },
                  child: Container(
                    // Container for styling
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.deepPurple, width: 2),
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          _showEditTodoDialog(context, todo, todo.name),
                      child: ListTile(
                        title: Text(
                          todo.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Checkbox(
                          value: todo.completed,
                          onChanged: (value) =>
                              BlocProvider.of<TodoBloc>(context)
                                  .add(ToggleTodoEvent(todo.id, value!)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SpinKitDoubleBounce(
                color: Colors.deepPurple,
                size: 50.0,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-todo');
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showEditTodoDialog(BuildContext context, Todo todo, String initialText) {
  final controller = TextEditingController(text: initialText);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Edit Todo'),
      content: TextField(
        controller: TextEditingController(text: todo.name),
        decoration: const InputDecoration(hintText: 'enter ur new todo'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              context
                  .read<TodoBloc>()
                  .add(UpdateTodoEvent(todo.id, controller.text));
            }
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
