import 'package:todo_app/core/data/todo_list.dart';
import 'package:todo_app/core/utils/typedef.dart';

abstract class ITodoRepository {
  ResultFuture<List<TodoList>> getTodos();
  ResultVoid addTodo(TodoList todo);
  ResultVoid updateTodo(TodoList todo);
  ResultVoid deleteTodo(int id);
}
