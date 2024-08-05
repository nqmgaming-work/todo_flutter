import 'package:flutter/material.dart';
import 'package:todo_list/core/themes/app_palette.dart';
import 'package:todo_list/futures/todo_list/domain/entities/category.dart';
import 'package:todo_list/futures/todo_list/presentation/pages/home_page.dart';
import 'package:todo_list/futures/todo_list/presentation/widgets/todo_textfield.dart';

class AddNewTodoPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewTodoPage());

  const AddNewTodoPage({super.key});

  @override
  State<AddNewTodoPage> createState() => _AddNewTodoPageState();
}

class _AddNewTodoPageState extends State<AddNewTodoPage> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var selectedCategory = Category.categories[0];

  void updateCategory(Category category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Add New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add new task
              if (formKey.currentState!.validate()) {
                // Add new task
                Navigator.pushAndRemoveUntil(
                    context, HomePage.route(), (route) => false);
              }
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.indigo,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back,
              color: Colors.indigo,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TodoTextField(
                  textController: titleController,
                  hintText: 'Task Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 16),
                      for (final category in Category.categories)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              updateCategory(category);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: category.colorUnCompleted,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: selectedCategory == category
                                      ? Colors.indigo
                                      : Colors.transparent,
                                  width: 5,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: category.colorCompleted,
                                child: Icon(
                                  category.icon,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TodoTextField(
                        textController: dateController,
                        hintText: 'Date',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date';
                          }
                          return null;
                        },
                        maxLength: 10,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: TodoTextField(
                        textController: timeController,
                        hintText: 'Time',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter time';
                          }
                          return null;
                        },
                        maxLength: 5,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TodoTextField(
                  textController: descriptionController,
                  hintText: 'Description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  maxLines: 5,
                  maxLength: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
