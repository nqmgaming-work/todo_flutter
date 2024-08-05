import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/futures/todo_list/data/datasources/dao/todo_dao.dart';
import 'package:todo_list/futures/todo_list/data/datasources/database.dart';
import 'package:todo_list/futures/todo_list/domain/entities/todo.dart';
import 'package:todo_list/futures/todo_list/domain/repositories/todo_repository.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final AppDatabase _appDatabase;

  TodoRepositoryImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @factoryMethod
  static TodoRepositoryImpl create(AppDatabase appDatabase) {
    return TodoRepositoryImpl(appDatabase: appDatabase);
  }

  @override
  Future<Either<Failure, Todo>> deleteTodo({required Todo todo}) async {
    try {
      final db = await _appDatabase.database;
      final todoDao = TodoDao(db);
      await todoDao.deleteTodo(todo.id);
      return Right(todo);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getAllTodos() async {
    try {
      final db = await _appDatabase.database;
      final todoDao = TodoDao(db);
      final todos = await todoDao.getAllTodos();
      return Right(todos);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> insertTodo({required Todo todo}) async {
    try {
      final db = await _appDatabase.database;
      final todoDao = TodoDao(db);
      await todoDao.insertTodo(todo);
      return Right(todo);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo({required Todo todo}) async {
    try {
      final db = await _appDatabase.database;
      final todoDao = TodoDao(db);
      await todoDao.updateTodo(todo);
      return Right(todo);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
