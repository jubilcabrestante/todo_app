import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/data/todo_list.dart';
import 'package:todo_app/core/repository/todo_repository.dart';

part 'todo_cubit.freezed.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;

  TodoCubit(this.todoRepository) : super(const TodoState()) {
    fetchTodo();
  }

  fetchTodo() async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));

    final result = await todoRepository.getTodos();

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: failure.errorMesage ?? 'Unexpected error.',
        ),
      ),
      (todos) =>
          emit(state.copyWith(isLoading: false, isSuccess: true, todo: todos)),
    );
  }

  addTodo(TodoList todo) async {
    final result = await todoRepository.addTodo(todo);

    result.fold(
      (failure) => emit(
        state.copyWith(
          hasError: true,
          errorMessage: failure.errorMesage ?? 'Failed to add todo.',
        ),
      ),
      (_) => fetchTodo(),
    );
  }

  updateTodo(TodoList todo) async {
    final result = await todoRepository.updateTodo(todo);

    result.fold(
      (failure) => emit(
        state.copyWith(
          hasError: true,
          errorMessage: failure.errorMesage ?? 'Failed to update todo.',
        ),
      ),
      (_) => fetchTodo(),
    );
  }

  deleteTodo(int id) async {
    final result = await todoRepository.deleteTodo(id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          hasError: true,
          errorMessage: failure.errorMesage ?? 'Failed to delete todo.',
        ),
      ),
      (_) => fetchTodo(),
    );
  }
}
