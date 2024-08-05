import 'package:fpdart/fpdart.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';
import 'package:todo_list/futures/todo_list/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class InsertTodo implements UseCase<Todo, Todo> {
  final TodoRepository todoRepository;
  InsertTodo({
    required this.todoRepository,
  });
  @override
  Future<Either<Failure, Todo>> call(Todo params) {
    return todoRepository.insertTodo(todo: params);
  }

}