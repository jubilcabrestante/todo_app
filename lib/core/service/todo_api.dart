import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_app/core/data/todo_list.dart';

part 'todo_api.g.dart';

@RestApi()
abstract class TodoApi {
  factory TodoApi(Dio dio, {String baseUrl}) = _TodoApi;

  @GET("/posts")
  Future<List<TodoList>> getTodos();

  @POST("/posts")
  Future<TodoList> createTodo(@Body() TodoList todo);

  @PUT("/posts/{id}")
  Future<TodoList> updateTodo(@Path("id") int id, @Body() TodoList todo);

  @DELETE("/posts/{id}")
  Future<void> deleteTodo(@Path("id") int id);
}
