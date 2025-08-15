import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/data/todo_list.dart';
import 'package:todo_app/core/domain/todo/todo_cubit.dart';
import 'package:todo_app/core/utils/app_button.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          SizedBox(
            width: 150,
            child: AppButton(
              label: "Add List",

              onPressed: () {
                _showEditDialog(context);
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        builder: (context, todoState) {
          return Column(
            children: [
              Expanded(
                child: todoState.todo == null
                    ? const Center(child: Text("No Todo Found"))
                    : todoList(),
              ),
            ],
          );
        },
        listener: (context, todoState) {
          if (todoState.hasError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(todoState.errorMessage)));
          }

          if (todoState.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Todo fetched successfully')),
            );
          }

          if (todoState.isLoading) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Loading...')));
          }
        },
      ),
    );
  }

  ListView todoList() => ListView.builder(
    itemBuilder: (context, index) {
      final todo = context.read<TodoCubit>().state.todo?[index];
      return ListTile(
        title: Text(todo?.title ?? 'No Title'),
        subtitle: Text(todo?.body ?? 'No Description'),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditDialog(context, todo!);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<TodoCubit>().deleteTodo(todo?.id ?? 0);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  void _showEditDialog(BuildContext context, [TodoList? todo]) {
    final title = TextEditingController(text: todo?.title);
    final body = TextEditingController(text: todo?.body);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Dialog"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(label: Text("Title")),
            ),
            TextField(
              controller: body,
              decoration: const InputDecoration(label: Text("Body")),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (todo == null) {
                final newTodo = TodoList(
                  userId: 1,
                  id: 0,
                  title: title.text,
                  body: body.text,
                );
                context.read<TodoCubit>().addTodo(newTodo);
              } else {
                final updatedTodo = TodoList(
                  userId: todo.userId,
                  id: todo.id,
                  title: title.text,
                  body: body.text,
                );
                context.read<TodoCubit>().updateTodo(updatedTodo);
              }
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
