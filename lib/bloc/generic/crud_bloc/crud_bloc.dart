import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/data_filter.dart';
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
    on<AppStarted<T>>(onAppStarted);
    on<DataProviderInitialized<T>>(onDataProviderInitialized);
    on<DataReceived<T>>(onDataReceived);
    on<DataLoadingFailed<T>>(onDataLoadingFailed);
    on<DataGetAllRequested<T>>(onDataGetAllRequested);
    on<DataGetWithFilterRequested<T>>(onDataGetWithFilterRequested);
    on<DataSaveRequested<T>>(onDataSaveRequested);
    on<DataRemoveRequested<T>>(onDataRemoveRequested);
  }

  @protected
  Future<void> onAppStarted(
    AppStarted<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    try {
      var service = await servicesProvider.databaseService;
      _repository = service.getRepository<T>();

      emit(InitSuccess());
      add(DataProviderInitialized());
    } catch (e) {
      emit(DataLoadError('Ошибка подключения к сервисам Firebase'));
      return;
    }
  }

  @protected
  Future<void> onDataProviderInitialized(
    DataProviderInitialized<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    add(DataGetAllRequested());
  }

  @protected
  void onDataReceived(DataReceived<T> event, Emitter<CrudState<T>> emit) {
    emit(DataLoadSuccess(event.data));
  }

  @protected
  void onDataLoadingFailed(
    DataLoadingFailed<T> event,
    Emitter<CrudState<T>> emit,
  ) {
    emit(DataLoadError(event.errorMessage));
  }

  @protected
  void onDataGetAllRequested(
    DataGetAllRequested<T> event,
    Emitter<CrudState<T>> emit,
  ) {
    assert(state is! Initial);
    emit(DataLoadInProgress());

    _subscription?.cancel();

    _subscription = _repository
        .getStreamAll()
        .listen((event) => add(DataReceived(event)))
      ..onError((e) => add(DataLoadingFailed(e.toString())));
  }

  @protected
  void onDataGetWithFilterRequested(
    DataGetWithFilterRequested<T> event,
    Emitter<CrudState<T>> emit,
  ) {
    assert(state is! Initial);
    emit(DataLoadInProgress());

    _subscription?.cancel();

    _subscription = event.filter
        .getData(_repository)
        .listen((event) => add(DataReceived(event)))
      ..onError((e) => add(DataLoadingFailed(e.toString())));
  }

  @protected
  Future<void> onDataSaveRequested(
    DataSaveRequested<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    assert(state is! Initial);
    await _repository.save(event.item);
  }

  @protected
  Future<void> onDataRemoveRequested(
    DataRemoveRequested<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    assert(state is! Initial);
    await _repository.remove(event.item);
  }
}
