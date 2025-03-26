sealed class Result<T> {
  const Result();
  const factory Result.ok(T value) = Ok._;
  const factory Result.error(Exception error) = Error._;

  R match<R>({
    required R Function(T value) onOk,
    required R Function(Exception error) onError,
  }) {
    return switch (this) {
      Ok(value: final value) => onOk(value),
      Error(error: final error) => onError(error),
    };
  }

  T unwrap() {
    return switch (this) {
      Ok(value: final value) => value,
      Error(error: final error) => throw error,
    };
  }

  bool get isOk => this is Ok<T>;

  bool get isError => this is Error<T>;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ok<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

final class Error<T> extends Result<T> {
  const Error._(this.error);
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
