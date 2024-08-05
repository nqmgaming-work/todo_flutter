import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';

class TodoDao {
  final Database _db;

  TodoDao(this._db);

  Future<void> insertTodo(Todo todo) async {
    final response = await _db.insert('Todo', {
      'id': todo.id,
      'taskTitle': todo.taskTitle,
      'taskDescription': todo.taskDescription,
      'categoryId': todo.category,
      'date': todo.date.millisecondsSinceEpoch,
      'time': todo.time.hour * 60 + todo.time.minute,
      'isCompleted': todo.isCompleted ? 1 : 0,
      'createdAt': todo.createdAt.millisecondsSinceEpoch,
      'updatedAt': todo.updatedAt.millisecondsSinceEpoch,
    });
    print('response: $response');
  }

  Future<void> updateTodo(Todo todo) async {
    await _db.update(
      'Todo',
      {
        'taskTitle': todo.taskTitle,
        'taskDescription': todo.taskDescription,
        'categoryId': todo.category,
        'date': todo.date.millisecondsSinceEpoch,
        'time': todo.time.hour * 60 + todo.time.minute,
        'isCompleted': todo.isCompleted ? 1 : 0,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    await _db.delete(
      'Todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Todo>> getAllTodos() async {
    final List<Map<String, dynamic>> maps = await _db.query('Todo');
    print('maps: $maps');
    return List.generate(
      maps.length,
      (i) {
        return Todo(
          id: maps[i]['id'],
          taskTitle: maps[i]['taskTitle'],
          taskDescription: maps[i]['taskDescription'],
          category: maps[i]['categoryId'],
          date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']),
          time: TimeOfDay(
            hour: maps[i]['time'] ~/ 60,
            minute: maps[i]['time'] % 60,
          ),
          isCompleted: maps[i]['isCompleted'] == 1,
        );
      },
    );
  }
}
