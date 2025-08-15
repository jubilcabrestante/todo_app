import 'package:dartz/dartz.dart';
import 'package:todo_app/core/data/todo_list.dart';
import 'package:todo_app/core/domain/i_todo_repository.dart';
import 'package:todo_app/core/service/todo_api.dart';
import 'package:todo_app/core/utils/typedef.dart';
import 'package:todo_app/core/utils/error_handler.dart';

class TodoRepository implements ITodoRepository {
  final TodoApi api;
  TodoRepository(this.api);

  @override
  ResultFuture<List<TodoList>> getTodos() async {
    try {
      final todo = await api.getTodos();
      return Right(todo);
    } catch (e) {
      return Left(ApiFailure(errorMesage: e.toString()));
    }
  }

  @override
  ResultVoid addTodo(TodoList todo) async {
    try {
      await api.createTodo(todo);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(errorMesage: e.toString()));
    }
  }

  @override
  ResultVoid updateTodo(TodoList todo) async {
    try {
      await api.updateTodo(todo.id, todo);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(errorMesage: e.toString()));
    }
  }

  @override
  ResultVoid deleteTodo(int id) async {
    try {
      await api.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(errorMesage: e.toString()));
    }
  }
}
