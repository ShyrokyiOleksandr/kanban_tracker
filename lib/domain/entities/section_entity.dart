class SectionEntity {
  final String id;
  final String projectId;
  final int order;
  final String name;

  SectionEntity({
    required this.id,
    required this.projectId,
    required this.order,
    required this.name,
  });

  @override
  bool operator ==(covariant SectionEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.projectId == projectId &&
        other.order == order &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ projectId.hashCode ^ order.hashCode ^ name.hashCode;
  }

  SectionEntity copyWith({
    String? id,
    String? projectId,
    int? order,
    String? name,
  }) {
    return SectionEntity(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      order: order ?? this.order,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'SectionEntity(id: $id, projectId: $projectId, order: $order, name: $name)';
  }
}
