class Result<T> {
  final T? data;
  final String? error;
  Result({required this.data, required this.error});
  factory Result.onSuccess(T data) {
    return Result(data: data, error: null);
  }
  factory Result.onfailure(String? error) {
    return Result(data: null, error: error);
  }

  bool get isFailure => data == null && error != null;
  bool get isSuccess => data != null && error == null;
}
