import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/models/todo_model.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState.initial(List<Todo> todos) = TodoInitial;
  const factory TodoState.loaded(List<Todo> todos) = TodoLoaded;
}
