import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/bloc/todo_state.dart';
import 'package:todo_list/models/todo_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo>? todos;

    Future<SharedPreferences> _getPrefs() async => await SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await _getPrefs();
    final String? encodedTodos = prefs.getString('todos');
    if (encodedTodos != null) {
      final List loadedTodos = decodeTodos(encodedTodos);
      setState(() {
        todos = loadedTodos.cast<Todo>();
        BlocProvider.of<TodoBloc>(context)
            .add(loadedTodos[0]); //potential error could occur
      });
    }
  }

  void _saveTodos() async {
    final prefs = await _getPrefs();
    final String encodedTodos = encodeTodos(todos!);
    prefs.setString('todos', encodedTodos);
  }

  @override
  void didUpdateWidget(covariant TodoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _saveTodos();
  }

  //encode and decode todos
  List decodeTodos(String encodedTodos) {
    final List<Map<String, dynamic>> decodedList = jsonDecode(encodedTodos);
    return decodedList.map((todoMap) => Todo.fromMap(todoMap)).toList();
  }

  String encodeTodos(List<Todo> todos) {
    final List encodedList = todos.map((todo) => todo.toMap()).toList();
    return jsonEncode(encodedList);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: Scaffold(
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
                  //final bool confirmToDelete;
                  return Dismissible(
                    key: Key(todo.id),
                    background: Container(
                      color: Colors.red,
                    ),
                    // confirmToDelete: true,
                    onDismissed: (direction) {
                      BlocProvider.of<TodoBloc>(context)
                          .add(DeleteTodoEvent(todo.id));
                      _saveTodos();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                            onChanged: (value) {
                              BlocProvider.of<TodoBloc>(context)
                                  .add(ToggleTodoEvent(todo.id, value!));
                              _saveTodos(); // Save todos after toggling
                            },
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
              //state._saveTodos();
            }
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
