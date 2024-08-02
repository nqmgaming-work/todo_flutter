import 'package:todo_list/futures/todo_list/domain/entities/category.dart';

class Todo {
  final String id;
  final String taskTitle;
  final String taskDescription;
  final Category category;
  final DateTime date;
  final DateTime time;
  final bool isCompleted;
  final DateTime createdAt = DateTime.now();
  final DateTime updatedAt = DateTime.now();

  Todo({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.category,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });

  Todo copyWith({
    String? taskTitle,
    String? taskDescription,
    Category? category,
    DateTime? date,
    DateTime? time,
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

  // mock data
  static List<Todo> todos = [
    Todo(
      taskTitle: 'Meeting with team',
      taskDescription: 'Discuss about the project',
      category: Category.categories[2],
      date: DateTime.now(),
      time: DateTime.now(),
      isCompleted: true,
      id: '1',
    ),
    Todo(
      taskTitle: 'Buy groceries',
      taskDescription: 'Buy milk, bread, eggs, etc.',
      category: Category.categories[4],
      date: DateTime.now(),
      time: DateTime.now(),
      isCompleted: true,
      id: '2',
    ),
    Todo(
      taskTitle: 'Go to gym',
      taskDescription: 'Do cardio and weight lifting',
      category: Category.categories[5],
      date: DateTime.now(),
      time: DateTime.now(),
      id: '3',
    ),
    Todo(
      taskTitle: 'Read a book',
      taskDescription: 'Read "The Lean Startup"',
      category: Category.categories[3],
      date: DateTime.now(),
      time: DateTime.now(),
      isCompleted: true,
      id: '4',
    ),
    Todo(
      taskTitle: 'Call mom',
      taskDescription: 'Wish her birthday',
      category: Category.categories[3],
      date: DateTime.now(),
      time: DateTime.now(),
      id: '5',
    ),
    Todo(
      taskTitle: 'Prepare for exam',
      taskDescription: 'Revise all the chapters',
      category: Category.categories[2],
      date: DateTime.now(),
      time: DateTime.now(),
      id: '6',
    ),
    Todo(
      taskTitle: 'Work on project',
      taskDescription: 'Complete the project on time',
      category: Category.categories[0],
      date: DateTime.now(),
      isCompleted: true,
      time: DateTime.now(),
      id: '7',
    ),
    Todo(
      taskTitle: 'Go for a walk',
      taskDescription: 'Walk for 30 minutes',
      category: Category.categories[1],
      date: DateTime.now(),
      isCompleted: true,
      time: DateTime.now(),
      id: '8',
    ),
  ];
}
