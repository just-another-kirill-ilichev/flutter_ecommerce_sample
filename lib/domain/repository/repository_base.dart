import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

abstract class RepositoryBase<TEntity extends Entity<TId>, TId> {
  Future<List<TEntity>> fetchAll();
  Future<List<TEntity>> fetchManyById(List<TId> ids);
  Future<TEntity> fetchById(TId id);

  Stream<List<TEntity>> getStreamAll();
  Stream<List<TEntity>> getStreamManyById(List<TId> ids);
  Stream<TEntity> getStreamById(TId id);

  Future<bool> containsById(TId id);
  Future<void> remove(TEntity entity);
  Future<TId> save(TEntity entity);
}
