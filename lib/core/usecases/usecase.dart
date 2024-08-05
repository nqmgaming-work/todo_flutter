import 'package:fpdart/fpdart.dart';
import 'package:todo_list/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
class NoParams {}