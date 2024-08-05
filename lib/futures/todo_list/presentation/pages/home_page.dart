import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/themes/app_palette.dart';
import 'package:todo_list/core/utils/get_current_date.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';
import 'package:todo_list/futures/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:todo_list/futures/todo_list/presentation/pages/add_new_or_update_todo_page.dart';
import 'package:todo_list/futures/todo_list/presentation/widgets/todo_container.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: AppPalette.backgroundColor,
        ),
        Container(
          color: Colors.indigo,
          height: 300,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              getCurrentDate(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.indigo,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, AddNewOrUpdateTodoPage.route());
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<TodoBloc, TodoState>(
              listener: (context, state) {
                if (state is TodoError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TodoLoaded) {
                  final List<Todo> todos = state.todos;
                  final List<Todo> uncompletedTodos =
                      todos.where((element) => !element.isCompleted).toList();
                  final List<Todo> completedTodos =
                      todos.where((element) => element.isCompleted).toList();
                  return Column(
                    children: [
                      const Text(
                        "My Todo List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        flex: 2,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white,
                          elevation: 0.1,
                          child: Column(
                            children: [
                              Expanded(
                                child: uncompletedTodos.isEmpty
                                    ? const Center(
                                        child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'No Task',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ))
                                    : ListView.builder(
                                        itemCount: uncompletedTodos.length,
                                        itemBuilder: (context, index) {
                                          return TodoCard(
                                            onTap: (todo) {
                                              Navigator.push(
                                                context,
                                                AddNewOrUpdateTodoPage.route(
                                                    todo: todo),
                                              );
                                            },
                                            todo: uncompletedTodos[index],
                                            isLast: index ==
                                                uncompletedTodos.length - 1,
                                            onDismissed: (id) {
                                              BlocProvider.of<TodoBloc>(context)
                                                  .add(
                                                DeleteTodoEvent(
                                                  todo: uncompletedTodos[index],
                                                ),
                                              );
                                            },
                                            onCompleted: (id, value) {
                                              BlocProvider.of<TodoBloc>(context)
                                                  .add(UpdateTodoEvent(
                                                todo: uncompletedTodos[index]
                                                    .copyWith(
                                                        isCompleted: value),
                                              ));
                                            },
                                          );
                                        },
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "You have ${uncompletedTodos.length} tasks",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 2,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white,
                          elevation: 0.1,
                          child: Column(
                            children: [
                              Expanded(
                                child: completedTodos.isEmpty
                                    ? const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'No Task',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: completedTodos.length,
                                        itemBuilder: (context, index) {
                                          return TodoCard(
                                            onTap: (todo) {
                                              Navigator.push(
                                                context,
                                                AddNewOrUpdateTodoPage.route(
                                                    todo: todo),
                                              );
                                            },
                                            todo: completedTodos[index],
                                            isLast: index ==
                                                completedTodos.length - 1,
                                            onDismissed: (id) {
                                              BlocProvider.of<TodoBloc>(context)
                                                  .add(DeleteTodoEvent(
                                                      todo: completedTodos[
                                                          index]));
                                            },
                                            onCompleted: (id, value) {
                                              BlocProvider.of<TodoBloc>(context)
                                                  .add(UpdateTodoEvent(
                                                todo: completedTodos[index]
                                                    .copyWith(
                                                        isCompleted: value),
                                              ));
                                            },
                                          );
                                        },
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "You have ${completedTodos.length} tasks",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ],
    );
  }
}
