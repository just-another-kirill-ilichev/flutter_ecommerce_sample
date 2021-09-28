part of 'crud_bloc.dart';

class CrudEvent<T> {}

class AppStarted<T> extends CrudEvent<T> {}

class DataReceived<T> extends CrudEvent<T> {
  final List<T> data;

  DataReceived(this.data);
}

class DataLoadingFailed<T> extends CrudEvent<T> {
  final String errorMessage;

  DataLoadingFailed(this.errorMessage);
}

class DataSaveRequested<T> extends CrudEvent<T> {
  final T item;

  DataSaveRequested(this.item);
}

class DataRemoveRequested<T> extends CrudEvent<T> {
  final T item;

  DataRemoveRequested(this.item);
}
