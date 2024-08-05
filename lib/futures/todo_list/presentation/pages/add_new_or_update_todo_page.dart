import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/themes/app_palette.dart';
import 'package:todo_list/core/utils/format_date.dart';
import 'package:todo_list/futures/todo_list/domain/entities/category.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';
import 'package:todo_list/futures/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:todo_list/futures/todo_list/presentation/pages/home_page.dart';
import 'package:todo_list/futures/todo_list/presentation/widgets/todo_textfield.dart';

class AddNewOrUpdateTodoPage extends StatefulWidget {
  static route({Todo? todo}) =>
      MaterialPageRoute(builder: (context) => AddNewOrUpdateTodoPage(todo: todo));

  final Todo? todo;

  const AddNewOrUpdateTodoPage({super.key, this.todo});

  @override
  State<AddNewOrUpdateTodoPage> createState() => _AddNewOrUpdateTodoPageState();
}

class _AddNewOrUpdateTodoPageState extends State<AddNewOrUpdateTodoPage> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late Category selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.todo != null) {
      titleController.text = widget.todo!.taskTitle;
      dateController.text = formatDate(widget.todo!.date.toString());
      timeController.text = widget.todo!.time.format(context);
      descriptionController.text = widget.todo!.taskDescription;
      selectedCategory = Category.categories.firstWhere((category) => category.id == widget.todo!.category);
      selectedDate = widget.todo!.date;
      selectedTime = widget.todo!.time;
    } else {
      selectedCategory = Category.categories[0];
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedDate = picked;
          dateController.text = formatDate(selectedDate.toString());
        });
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedTime = picked;
          timeController.text = selectedTime?.format(context) ?? '';
        });
      });
    }
  }

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
        title: Text(
          widget.todo == null ? 'Add New Task' : 'Edit Task',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final todo = Todo(
                  id: widget.todo?.id,
                  taskTitle: titleController.text.trim(),
                  category: selectedCategory.id,
                  date: selectedDate!,
                  time: selectedTime!,
                  taskDescription: descriptionController.text.trim(),
                  isCompleted: widget.todo?.isCompleted ?? false,
                );
                if (widget.todo == null) {
                  context.read<TodoBloc>().add(AddTodoEvent(todo: todo));
                } else {
                  context.read<TodoBloc>().add(UpdateTodoEvent(todo: todo));
                }
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
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is TodoLoaded) {
            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TodoTextField(
                      value: titleController.text,
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
                            value: formatDate(selectedDate.toString()),
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                            textController: dateController,
                            hintText: 'Date',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter date';
                              }
                              return null;
                            },
                            maxLength: 30,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: TodoTextField(
                            value: selectedTime?.format(context) ?? '',
                            readOnly: true,
                            onTap: () {
                              _selectTime(context);
                            },
                            textController: timeController,
                            hintText: 'Time',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter time';
                              }
                              return null;
                            },
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TodoTextField(
                      textInputAction: TextInputAction.done,
                      value: descriptionController.text,
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
          );
        },
      ),
    );
  }
}