abstract class DataState<T> {
  T? get data;
}

class DataStateSuccess<T> extends DataState<T> {
  final T? data;
  DataStateSuccess(this.data);
}

class DataStateError<T> extends DataState<T> {
  final T? data;
  final String message;
  DataStateError(this.data, this.message);
}

class DataStateLoading<T> extends DataState<T> {
  final T? data;
  DataStateLoading(this.data);
}

class DataStateIdle<T> extends DataState<T> {
  final T? data;
  DataStateIdle(this.data);
}
