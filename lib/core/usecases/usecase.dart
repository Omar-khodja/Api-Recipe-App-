import 'package:recipe_app/core/result.dart';

abstract class UseCases<T , Params>{
  Future<ResultState<T>> call(Params params);
}
class NoParams {
  const NoParams();
}
