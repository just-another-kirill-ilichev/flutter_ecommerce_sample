import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

abstract class RepositoryBase<TEntity extends Entity<TId>, TId> {
  Future<List<TEntity>> fetchAll();
  Future<TEntity> fetchById(TId id);
  Stream<List<TEntity>> getStreamAll();
  Stream<TEntity> getStreamById(TId id);

  Future<bool> containsById(TId id);
  Future<void> removeById(TId id);
  Future<void> save(TEntity entity);
}
