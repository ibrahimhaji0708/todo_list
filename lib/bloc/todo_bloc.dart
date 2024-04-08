//import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial([])) {
    on<AddTodoEvent>((event, emit) {
      final todolist = [
        ...state.todos,
        Todo(
            id: DateTime.now().millisecond.toString(),
            name: event.todo,
            completed: false),
      ];

      print('::::list len ' + todolist.length.toString());
      emit(TodoLoaded(todolist));
    });
    on<UpdateTodoEvent>((event, emit) {
      final updatedTodos = state.todos
          .map((todo) =>
              todo.id == event.id ? todo.copyWith(name: event.newTitle) : todo)
          .toList();
      emit(TodoLoaded(updatedTodos));
    });
    on<DeleteTodoEvent>((event, emit) => emit(
        TodoLoaded(state.todos.where((todo) => todo.id != event.id).toList())));
    on<ToggleTodoEvent>((event, emit) {
      final updatedTodos = state.todos
          .map((todo) => todo.id == event.id
              ? todo.copyWith(completed: event.completed)
              : todo)
          .toList();
      emit(TodoLoaded(updatedTodos));
    });
  }
 }
