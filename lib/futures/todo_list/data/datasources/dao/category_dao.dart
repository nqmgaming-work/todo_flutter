import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/futures/todo_list/domain/entities/category.dart';

class CategoryDao {
  final Database _database;

  CategoryDao(this._database);

  Future<void> insertCategory(Category category) async {
    await _database.insert('Category', {
      'id': category.id,
      'name': category.name,
      'icon': category.icon.codePoint,
      'colorCompleted': category.colorCompleted.value,
      'colorUnCompleted': category.colorUnCompleted.value,
    });
  }

  Future<void> updateCategory(Category category) async {
    await _database.update(
      'Category',
      {
        'name': category.name,
        'icon': category.icon.codePoint,
        'colorCompleted': category.colorCompleted.value,
        'colorUnCompleted': category.colorUnCompleted.value,
      },
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<void> deleteCategory(String id) async {
    await _database.delete(
      'Category',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Category>> getAllCategories() async {
    final List<Map<String, dynamic>> maps = await _database.query('Category');
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
        icon: IconData(maps[i]['icon'], fontFamily: 'MaterialIcons'),
        colorCompleted: Color(maps[i]['colorCompleted']),
        colorUnCompleted: Color(maps[i]['colorUnCompleted']),
      );
    });
  }
}
