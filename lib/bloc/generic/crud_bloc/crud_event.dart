part of 'crud_bloc.dart';

class CrudEvent<T extends Entity<String>> {}

class AppStarted<T extends Entity<String>> extends CrudEvent<T> {}

class DataProviderInitialized<T extends Entity<String>> extends CrudEvent<T> {}

class DataReceived<T extends Entity<String>> extends CrudEvent<T> {
  final List<T> data;

  DataReceived(this.data);
}

class DataLoadingFailed<T extends Entity<String>> extends CrudEvent<T> {
  final String errorMessage;

  DataLoadingFailed(this.errorMessage);
}

class DataGetAllRequested<T extends Entity<String>> extends CrudEvent<T> {}

class DataGetWithFilterRequested<T extends Entity<String>>
    extends CrudEvent<T> {
  final DataFilter<T, String> filter;

  DataGetWithFilterRequested(this.filter);
}

class DataSaveRequested<T extends Entity<String>> extends CrudEvent<T> {
  final T item;

  DataSaveRequested(this.item);
}

class DataRemoveRequested<T extends Entity<String>> extends CrudEvent<T> {
  final T item;

  DataRemoveRequested(this.item);
}
