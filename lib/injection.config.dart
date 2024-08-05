// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'futures/todo_list/data/datasources/database.dart' as _i3;
import 'futures/todo_list/data/repositories/todo_repository_impl.dart' as _i5;
import 'futures/todo_list/domain/repositories/todo_repository.dart' as _i4;
import 'futures/todo_list/domain/usecases/delete_todo.dart' as _i8;
import 'futures/todo_list/domain/usecases/get_all_todos.dart' as _i6;
import 'futures/todo_list/domain/usecases/insert_todo.dart' as _i7;
import 'futures/todo_list/domain/usecases/update_todo.dart' as _i9;
import 'futures/todo_list/presentation/bloc/todo_bloc.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
    gh.lazySingleton<_i4.TodoRepository>(
        () => _i5.TodoRepositoryImpl.create(gh<_i3.AppDatabase>()));
    gh.factory<_i6.GetAllTodos>(
        () => _i6.GetAllTodos(todoRepository: gh<_i4.TodoRepository>()));
    gh.factory<_i7.InsertTodo>(
        () => _i7.InsertTodo(todoRepository: gh<_i4.TodoRepository>()));
    gh.factory<_i8.DeleteTodo>(
        () => _i8.DeleteTodo(todoRepository: gh<_i4.TodoRepository>()));
    gh.factory<_i9.UpdateTodo>(
        () => _i9.UpdateTodo(todoRepository: gh<_i4.TodoRepository>()));
    gh.factory<_i10.TodoBloc>(() => _i10.TodoBloc(
          getAllTodos: gh<_i6.GetAllTodos>(),
          insertTodo: gh<_i7.InsertTodo>(),
          deleteTodo: gh<_i8.DeleteTodo>(),
          updateTodo: gh<_i9.UpdateTodo>(),
        ));
    return this;
  }
}
