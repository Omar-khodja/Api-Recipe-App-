import 'package:recipe_app/core/error/failure.dart';

sealed class ResultState<T> {
  const ResultState();
}
class SuccessState<T> extends ResultState<T> {
  final T data;
  const SuccessState(this.data);
}
class ErrorState<T> extends ResultState<T> {
  final Failure errorMessage;
  const ErrorState(this.errorMessage);
}
class LoadingState<T> extends ResultState<T> {
  const LoadingState();
}
