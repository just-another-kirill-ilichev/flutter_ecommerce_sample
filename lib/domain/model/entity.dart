abstract class Entity<T> {
  final T? id;

  Entity(this.id);

  Map<String, dynamic> toMap();
}
