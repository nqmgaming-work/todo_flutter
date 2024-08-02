import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color colorUnCompleted;
  final Color colorCompleted;
  final String id;

  Category({
    required this.name,
    required this.icon,
    required this.colorCompleted,
    required this.colorUnCompleted,
    isCompleted = false,
    required this.id,
  });

  // list of categories
  static List<Category> categories = [
    Category(
      name: 'Work',
      icon: Icons.work,
      colorCompleted: Colors.green,
      colorUnCompleted: Colors.green[900]!,
      id: '1',
    ),
    Category(
      name: 'Personal',
      icon: Icons.person,
      colorCompleted: Colors.blue,
      colorUnCompleted: Colors.blue[900]!,
      id: '2',
    ),
    Category(
      name: 'Meeting',
      icon: Icons.meeting_room,
      colorCompleted: Colors.orange,
      colorUnCompleted: Colors.orange[900]!,
      id: '3',
    ),
    Category(
      name: 'Shopping',
      icon: Icons.shopping_cart,
      colorCompleted: Colors.purple,
      colorUnCompleted: Colors.purple[900]!,
      id: '4',
    ),
    Category(
      name: 'Home',
      icon: Icons.home,
      colorCompleted: Colors.teal,
      colorUnCompleted: Colors.teal[900]!,
      id: '5',
    ),
    Category(
      name: 'Others',
      icon: Icons.category,
      colorCompleted: Colors.red,
      colorUnCompleted: Colors.red[900]!,
      id: '6',
    ),
  ];
}
