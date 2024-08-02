import 'package:flutter/material.dart';

class AddNewTodoPage extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewTodoPage());

  const AddNewTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: Center(
        child: Text('Add New Todo Page'),
      ),
    );
  }
}
