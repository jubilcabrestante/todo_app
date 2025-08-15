import 'package:json_annotation/json_annotation.dart';

part 'todo_list.g.dart';

@JsonSerializable()
class TodoList {
  final int userId;
  final int id;
  final String title;
  final String body;

  const TodoList({
    required this.userId,
    required this.id,
    required this.body,
    required this.title,
  });

  factory TodoList.fromJson(Map<String, dynamic> json) =>
      _$TodoListFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListToJson(this);
}
