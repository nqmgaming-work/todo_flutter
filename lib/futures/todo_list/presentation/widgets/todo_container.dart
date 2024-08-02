import 'package:flutter/material.dart';
import 'package:todo_list/core/utils/get_time.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final bool isLast;
  final Function(String) onDismissed;
  final Function(String, bool) onCompleted;

  const TodoCard({
    super.key,
    required this.todo,
    required this.isLast,
    required this.onDismissed,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = todo.isCompleted;
    return Dismissible(
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      key: ValueKey(todo.id),
      onDismissed: (direction) {
        onDismissed(todo.id);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isCompleted
                ? todo.category.colorCompleted
                : todo.category.colorUnCompleted,
            child: Icon(todo.category.icon),
          ),
          title: Text(
            todo.taskTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(getTime(todo.time.toString())),
          trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) {
                onCompleted(todo.id, value!);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              side: const BorderSide(
                color: Colors.grey,
              )),
        ),
      ),
    );
  }
}
