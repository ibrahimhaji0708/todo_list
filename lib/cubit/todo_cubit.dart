// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_list/models/todo_model.dart';

// class TodoCubit extends Cubit<List<Todo>> {
//   TodoCubit() : super([]);

//   void addTodo(String title) {
//     final todo = Todo(name: title, id: '', completed: false);
//     //state.add(todo);
//     emit([...state, todo]);
//   }

//   @override
//   void onChange(Change<List<Todo>> change) {
//     super.onChange(change);
//     print('TodoCubit - $change');
//   }

//   void updateTodo(String id, String trim) {}

//   void deleteTodo(String id) {}

//   toggleTodo(String id, bool bool) {}
// }
