import 'package:flutter/material.dart';
import 'package:todo_list/futures/todo_list/domain/entities/category.dart';
import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String taskTitle;
  final String taskDescription;
  final String category;
  final DateTime date;
  final TimeOfDay time;
  final bool isCompleted;
  final DateTime createdAt = DateTime.now();
  final DateTime updatedAt = DateTime.now();

  Todo({
    required this.taskTitle,
    required this.taskDescription,
    required this.category,
    required this.date,
    required this.time,
    this.isCompleted = false,
    String? id,
  }) : id = id ?? const Uuid().v4();

  Todo copyWith({
    String? taskTitle,
    String? taskDescription,
    String? category,
    DateTime? date,
    TimeOfDay? time,
    bool? isCompleted,
    String? id,
  }) {
    return Todo(
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }

}
