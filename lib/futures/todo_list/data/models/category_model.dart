import 'package:flutter/material.dart';
import 'package:todo_list/futures/todo_list/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.name,
    required super.icon,
    required super.colorCompleted,
    required super.colorUnCompleted,
    required super.id,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      icon: map['icon'] as IconData,
      colorCompleted: map['colorCompleted'] as Color,
      colorUnCompleted: map['colorUnCompleted'] as Color,
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'colorCompleted': colorCompleted,
      'colorUnCompleted': colorUnCompleted,
      'id': id,
    };
  }
}
