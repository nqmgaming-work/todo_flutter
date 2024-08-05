import 'package:fpdart/fpdart.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';
import 'package:todo_list/core/error/failures.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, Todo>> insertTodo({
    required Todo todo,
  });
  Future<Either<Failure, Todo>> updateTodo({
    required Todo todo,
  });
  Future<Either<Failure, Todo>> deleteTodo({
    required Todo todo,
  });
  Future<Either<Failure, List<Todo>>> getAllTodos();
}