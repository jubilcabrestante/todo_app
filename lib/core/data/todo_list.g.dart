// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoList _$TodoListFromJson(Map<String, dynamic> json) => TodoList(
  userId: (json['userId'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  body: json['body'] as String,
  title: json['title'] as String,
);

Map<String, dynamic> _$TodoListToJson(TodoList instance) => <String, dynamic>{
  'userId': instance.userId,
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
};
