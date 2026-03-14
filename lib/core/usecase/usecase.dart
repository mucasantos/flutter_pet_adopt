abstract class UseCase<Result, Params> {
  Future<Result> call(Params params);
}

class NoParams {
  const NoParams();
}
