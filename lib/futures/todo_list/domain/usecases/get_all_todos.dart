import 'package:fpdart/fpdart.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';
import 'package:todo_list/futures/todo_list/domain/repositories/todo_repository.dart';

class GetAllTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository todoRepository;

  GetAllTodos({
    required this.todoRepository,
  });

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await todoRepository.getAllTodos();
  }
}