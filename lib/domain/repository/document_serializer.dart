import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

typedef EntityFactory<T extends Entity<String>> = T Function(
    String id, Map<String, dynamic> data);

class DocumentSerializer<T extends Entity<String>> {
  final EntityFactory<T> entityFactory;

  DocumentSerializer(this.entityFactory);

  T? deserialize(DocumentSnapshot doc) {
    if (!doc.exists || doc.data() is! Map<String, dynamic>) {
      return null;
    }

    return entityFactory(doc.id, doc.data() as Map<String, dynamic>);
  }

  Map<String, dynamic> serialize(T entity) => entity.toMap();

  List<T?> deserializeMany(List<DocumentSnapshot> docs) =>
      docs.map((e) => deserialize(e)).toList();

  List<Map<String, dynamic>> serializeMany(List<T> entities) =>
      entities.map((e) => serialize(e)).toList();
}
