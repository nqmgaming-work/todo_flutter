import 'package:flutter/material.dart';
import 'package:todo_list/futures/todo_list/domain/entities/category.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final bool isLast;
  final Function(String) onDismissed;
  final Function(String, bool) onCompleted;
  final Function(Todo) onTap;

  const TodoCard({
    super.key,
    required this.todo,
    required this.isLast,
    required this.onDismissed,
    required this.onCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = todo.isCompleted;
    final Category category = Category.categories.firstWhere(
      (element) => element.id == todo.category,
    );
    return ClipRRect(
      child: Dismissible(
        background: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.red,
          ),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        key: ValueKey(todo.id),
        onDismissed: (_) {
          onDismissed(todo.id);
        },
        child: GestureDetector(
          onTap: () {
            onTap(todo);
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
                    ? category.colorUnCompleted
                    : category.colorCompleted,
                child: Icon(
                  category.icon,
                  color: Colors.white,
                ),
              ),
              title: Text(
                todo.taskTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(todo.time.format(context)),
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
        ),
      ),
    );
  }
}
