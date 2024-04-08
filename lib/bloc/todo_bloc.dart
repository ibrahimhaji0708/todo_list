// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_list/models/todo_model.dart';

// part 'todo_event.dart';
// part 'todo_state.dart';

// class TodoBloc extends Bloc<TodoEvent, TodoState> {
//   TodoBloc() : super(TodoInitial([])) {
//     on<AddTodoEvent>((event, emit) {
//       final todo = Todo(name: event.title, id: UniqueKey().toString(), completed: false);
//       emit(TodoLoaded([...state.todos, todo]));
//     });

//     on<UpdateTodoEvent>((event, emit) {
//       final updatedTodos = state.todos.map((todo) {
//         if (todo.id == event.id) {
//           return todo.copyWith(name: event.newTitle);
//         } else {
//           return todo;
//         }
//       }).toList();
//       emit(TodoLoaded(updatedTodos));
//     });

//     on<DeleteTodoEvent>((event, emit) {
//       final filteredTodos =
//           state.todos.where((todo) => todo.id != event.id).toList();
//       emit(TodoLoaded(filteredTodos));
//     });

//     on<ToggleTodoEvent>((event, emit) {
//       final updatedTodos = state.todos.map((todo) {
//         if (todo.id == event.id) {
//           return todo.copyWith(completed: event.completed);
//         } else {
//           return todo;
//         }
//       }).toList();
//       emit(TodoLoaded(updatedTodos));
//     });
//   }

//   void updateTodo(String id, String trim) {}

//   void addTodo(String trim) {}

//   void deleteTodo(String id) {}
// }
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial([])) {
    on<AddTodoEvent>((event, emit) => emit(TodoLoaded([...state.todos, event.todo])));
    on<UpdateTodoEvent>((event, emit) {
      final updatedTodos = state.todos.map((todo) => todo.id == event.id ? todo.copyWith(name: event.newTitle) : todo).toList();
      emit(TodoLoaded(updatedTodos));
    });
    on<DeleteTodoEvent>((event, emit) => emit(TodoLoaded(state.todos.where((todo) => todo.id != event.id).toList())));
    on<ToggleTodoEvent>((event, emit) {
      final updatedTodos = state.todos.map((todo) => todo.id == event.id ? todo.copyWith(completed: event.completed) : todo).toList();
      emit(TodoLoaded(updatedTodos));
    });
  }
  void addTodo(String title) => add(AddTodoEvent(Todo(name: title, id: UniqueKey().toString(), completed: false)));
  void updateTodo(String id, String newTitle) => add(UpdateTodoEvent(id, newTitle));
  void deleteTodo(String id) => add(DeleteTodoEvent(id));
}
