part of 'todo_cubit.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
    List<TodoList>? todo,
  }) = _TodoState;
}
