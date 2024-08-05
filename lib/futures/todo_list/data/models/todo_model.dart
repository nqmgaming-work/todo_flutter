import 'package:todo_list/futures/todo_list/domain/entities/category.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.taskTitle,
    required super.taskDescription,
    required super.category,
    required super.date,
    required super.time,
    isCompleted,
    createdAt,
    updatedAt,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      taskTitle: map['taskTitle'] as String,
      taskDescription: map['taskDescription'] as String,
      category: map['category'] as Category,
      date: map['date'] as DateTime,
      time: map['time'] as DateTime,
      isCompleted: map['isCompleted'] as bool,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'category': category,
      'date': date,
      'time': time,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
