import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_sample/domain/model/entity.dart';
import 'package:flutter_ecommerce_sample/domain/repository/repository_base.dart';
import 'package:flutter_ecommerce_sample/domain/repository/document_serializer.dart';

class FirebaseRepository<T extends Entity<String>>
    extends RepositoryBase<T, String> {
  final _firestoreInstance = FirebaseFirestore.instance;

  final String collectionPath;
  final DocumentSerializer<T> serializer;

  CollectionReference get _collectionReference =>
      _firestoreInstance.collection(collectionPath);

  FirebaseRepository(this.collectionPath, this.serializer);

  @override
  Future<bool> containsById(String id) async {
    var doc = await _collectionReference.doc(id).get();
    return doc.exists;
  }

  @override
  Future<List<T>> fetchAll() async =>
      serializer.deserializeMany((await _collectionReference.get()).docs);

  @override
  Future<T> fetchById(String id) async =>
      serializer.deserialize(await _collectionReference.doc(id).get());

  @override
  Stream<List<T>> getStreamAll() => _collectionReference
      .snapshots()
      .map((snapshot) => serializer.deserializeMany(snapshot.docs));

  @override
  Stream<T> getStreamById(String id) => _collectionReference
      .doc(id)
      .snapshots()
      .map((doc) => serializer.deserialize(doc));

  @override
  Future<void> removeById(String id) async =>
      _collectionReference.doc(id).delete();

  @override
  Future<String> save(T entity) async {
    var data = serializer.serialize(entity);

    if (entity.id == null) {
      var ref = await _collectionReference.add(data);
      return ref.id;
    } else {
      _collectionReference.doc(entity.id).set(data);
      return entity.id!;
    }
  }
}
