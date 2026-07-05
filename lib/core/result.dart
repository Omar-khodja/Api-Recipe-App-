import 'package:recipe_app/core/error/failure.dart';

sealed class Result<T>{
  const Result();
}
class Success<T> extends Result<T>{
  final T data;
  const Success(this.data);
}
class Error<T> extends Result<T>{
  final Failure errorMessage;
  const Error(this.errorMessage);
}
class Loading<T> extends Result<T> {
  const Loading();
}
