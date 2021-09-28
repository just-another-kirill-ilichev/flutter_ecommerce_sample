part of 'crud_bloc.dart';

class CrudState<T> {}

class Initial<T> extends CrudState<T> {}

class DataLoadInProgress<T> extends CrudState<T> {}

class DataLoadSuccess<T> extends CrudState<T> {
  final List<T> data;

  DataLoadSuccess(this.data);
}

class DataLoadError<T> extends CrudState<T> {
  final String errorMessage;

  DataLoadError(this.errorMessage);
}
