class Failure  {
  final String message;

  const Failure(this.message);

}

class ApiFailure extends Failure {
  const ApiFailure(super.message); 
}
