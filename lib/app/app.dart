import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/domain/todo/todo_cubit.dart';
import 'package:todo_app/core/domain/i_todo_repository.dart';
import 'package:todo_app/core/repository/todo_repository.dart';
import 'package:todo_app/core/service/todo_api.dart';
import 'package:todo_app/features/todo_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Dio _dio;
  late TodoApi _todoApi;
  late TodoRepository _todoRepository;
  String? token;
  String baseUrl = "https://jsonplaceholder.typicode.com";

  @override
  void initState() {
    super.initState();
    _dio = _initTodo();
    _todoApi = TodoApi(_dio);
    _todoRepository = TodoRepository(_todoApi);
  }

  @override
  Widget build(BuildContext context) {
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<ITodoRepository>.value(value: _todoRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TodoCubit(_todoRepository)),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: TodoScreen(),
        ),
      ),
    );
  }

  Dio _initTodo() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      contentType: Headers.jsonContentType,
      headers: {'Accept': Headers.acceptHeader},
      validateStatus: (status) {
        return status != null;
      },
    );
    return Dio(baseOptions);
  }
}
