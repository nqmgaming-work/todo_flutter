import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/futures/todo_list/domain/entities/category.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';

class TodoDao {
  final Database _db;

  TodoDao(this._db);

  Future<void> insertTodo(Todo todo) async {
    await _db.insert('Todo', {
      'id': todo.id,
      'taskTitle': todo.taskTitle,
      'taskDescription': todo.taskDescription,
      'categoryId': todo.category.id,
      'date': todo.date.millisecondsSinceEpoch,
      'time': todo.time.millisecondsSinceEpoch,
      'isCompleted': todo.isCompleted ? 1 : 0,
      'createdAt': todo.createdAt.millisecondsSinceEpoch,
      'updatedAt': todo.updatedAt.millisecondsSinceEpoch,
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await _db.update(
      'Todo',
      {
        'taskTitle': todo.taskTitle,
        'taskDescription': todo.taskDescription,
        'categoryId': todo.category.id,
        'date': todo.date.millisecondsSinceEpoch,
        'time': todo.time.millisecondsSinceEpoch,
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
    final List<Map<String, dynamic>> maps = await _db.rawQuery('''
      SELECT 
        Todo.id as todoId, 
        Todo.taskTitle, 
        Todo.taskDescription, 
        Todo.categoryId, 
        Todo.date, 
        Todo.time, 
        Todo.isCompleted, 
        Todo.createdAt, 
        Todo.updatedAt, 
        Category.id as categoryId, 
        Category.name as categoryName, 
        Category.icon as categoryIcon, 
        Category.colorCompleted as categoryColorCompleted, 
        Category.colorUnCompleted as categoryColorUnCompleted 
      FROM Todo 
      INNER JOIN Category ON Todo.categoryId = Category.id
    ''');

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['todoId'],
        taskTitle: maps[i]['taskTitle'],
        taskDescription: maps[i]['taskDescription'],
        category: Category(
          id: maps[i]['categoryId'],
          name: maps[i]['categoryName'],
          icon: IconData(maps[i]['categoryIcon'], fontFamily: 'MaterialIcons'),
          colorCompleted: Color(maps[i]['categoryColorCompleted']),
          colorUnCompleted: Color(maps[i]['categoryColorUnCompleted']),
        ),
        date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']),
        time: DateTime.fromMillisecondsSinceEpoch(maps[i]['time']),
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }
}