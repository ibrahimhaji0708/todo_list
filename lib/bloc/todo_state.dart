// part of 'todo_bloc.dart';

// abstract class TodoState {
//   final List<Todo> todos;
//   TodoState(this.todos);
// }

// class TodoInitial extends TodoState {
//   TodoInitial(super.todos);
// }

// class TodoLoaded extends TodoState {
//   @override
//   final List<Todo> todos; 

//   TodoLoaded(this.todos) : super(todos);
// }
part of 'todo_bloc.dart';

abstract class TodoState {
  final List<Todo> todos;
  TodoState(this.todos);
}

class TodoInitial extends TodoState {
  TodoInitial(super.todos);
}

class TodoLoaded extends TodoState {
  @override
  final List<Todo> todos;

  TodoLoaded(this.todos) : super(todos);
}
