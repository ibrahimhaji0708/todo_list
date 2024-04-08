// class Todo {
//   final String id;
//   final String name;
//   final bool completed;
//   //final DateTime createdAt;

//   Todo({
//     required this.id,
//     required this.name,
//     required this.completed,
//     //required this.createdAt,
//   });

//   Todo copyWith({
//     String? id,
//     String? name,
//     bool? completed,
//     //DateTime? createdAt,
//   }) {
//     return Todo(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       completed: completed ?? this.completed,
//       //createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }

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
}
