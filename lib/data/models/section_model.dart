import 'package:kanban_tracker/domain/entities/section_entity.dart';

class SectionModel {
  final String id;
  final String projectId;
  final int order;
  final String name;

  SectionModel({
    required this.id,
    required this.projectId,
    required this.order,
    required this.name,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      order: json['order'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'order': order,
      'name': name,
    };
  }

  SectionEntity toDomain() {
    return SectionEntity(
      id: id,
      projectId: projectId,
      order: order,
      name: name,
    );
  }

  @override
  bool operator ==(covariant SectionModel other) {
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

  SectionModel copyWith({
    String? id,
    String? projectId,
    int? order,
    String? name,
  }) {
    return SectionModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      order: order ?? this.order,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'SectionModel(id: $id, projectId: $projectId, order: $order, name: $name)';
  }
}
