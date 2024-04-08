//implementing it in freezed class
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String name,
    required bool completed,
    //required DateTime createdAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  static fromMap(Map<String, dynamic> todoMap) {}

  toMap() {}
}
//freezed.dart line 162 extra override