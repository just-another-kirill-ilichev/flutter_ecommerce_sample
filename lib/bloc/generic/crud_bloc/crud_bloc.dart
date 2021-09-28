import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/entity.dart';
import 'package:flutter_ecommerce_sample/domain/repository/repository_base.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc<T extends Entity<String>>
    extends Bloc<CrudEvent<T>, CrudState<T>> {
  final ServiceProvider servicesProvider;

  late RepositoryBase<T, String> _repository;
  StreamSubscription? _subscription;

  CrudBloc(this.servicesProvider) : super(Initial<T>()) {
    on<AppStarted<T>>(_onAppStarted);
    on<DataReceived<T>>(_onDataReceived);
    on<DataLoadingFailed<T>>(_onDataLoadingFailed);
    on<DataSaveRequested<T>>(_onDataSaveRequested);
    on<DataRemoveRequested<T>>(_onDataRemoveRequested);
  }

  Future<void> _onAppStarted(
    AppStarted<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    try {
      var service = await servicesProvider.databaseService;
      _repository = service.getRepository<T>();
    } catch (e) {
      emit(DataLoadError('Ошибка подключения к сервисам Firebase'));
      return;
    }

    emit(DataLoadInProgress());

    _subscription = _repository
        .getStreamAll()
        .listen((event) => add(DataReceived(event)))
      ..onError((e) => add(DataLoadingFailed(e.toString())));
  }

  void _onDataReceived(DataReceived<T> event, Emitter<CrudState<T>> emit) {
    emit(DataLoadSuccess(event.data));
  }

  void _onDataLoadingFailed(
    DataLoadingFailed<T> event,
    Emitter<CrudState<T>> emit,
  ) {
    emit(DataLoadError(event.errorMessage));
  }

  Future<void> _onDataSaveRequested(
    DataSaveRequested<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    assert(state is! Initial);
    await _repository.save(event.item);
  }

  Future<void> _onDataRemoveRequested(
    DataRemoveRequested<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    assert(state is! Initial);
    await _repository.remove(event.item);
  }
}
