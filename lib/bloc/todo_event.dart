// part of 'todo_bloc.dart';

// abstract class TodoEvent {}

// class AddTodoEvent extends TodoEvent {
//   final String title;
//   final Todo todo;

//   AddTodoEvent(this.title, this.todo);
// }

// class UpdateTodoEvent extends TodoEvent {
//   final String id;
//   final String newTitle;

//   UpdateTodoEvent(this.id, this.newTitle);
// }

// class DeleteTodoEvent extends TodoEvent {
//   final String id;

//   DeleteTodoEvent(this.id);
// }

// class ToggleTodoEvent extends TodoEvent {
//   final String id;
//   final bool completed;

//   ToggleTodoEvent(this.id, this.completed);
// }
part of 'todo_bloc.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String newTitle;

  UpdateTodoEvent(this.id, this.newTitle);
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent(this.id);
}

class ToggleTodoEvent extends TodoEvent {
  final String id;
  final bool completed;

  ToggleTodoEvent(this.id, this.completed);
}
