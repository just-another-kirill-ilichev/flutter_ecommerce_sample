import 'package:flutter_ecommerce_sample/domain/model/entity.dart';
import 'package:flutter_ecommerce_sample/domain/repository/repository_base.dart';

abstract class DataFilter<TEntity extends Entity<TId>, TId> {
  Stream<List<TEntity>> getData(RepositoryBase<TEntity, TId> repository);
}

class AllDataFilter<TEntity extends Entity<TId>, TId>
    extends DataFilter<TEntity, TId> {
  @override
  Stream<List<TEntity>> getData(RepositoryBase<TEntity, TId> repository) {
    return repository.getStreamAll();
  }
}

class NoDataFilter<TEntity extends Entity<TId>, TId>
    extends DataFilter<TEntity, TId> {
  @override
  Stream<List<TEntity>> getData(RepositoryBase<TEntity, TId> repository) {
    return Stream.value([]);
  }
}

class WithIdDataFilter<TEntity extends Entity<TId>, TId>
    extends DataFilter<TEntity, TId> {
  final List<TId> ids;

  WithIdDataFilter(this.ids);

  @override
  Stream<List<TEntity>> getData(RepositoryBase<TEntity, TId> repository) =>
      repository.getStreamManyById(ids);
}
