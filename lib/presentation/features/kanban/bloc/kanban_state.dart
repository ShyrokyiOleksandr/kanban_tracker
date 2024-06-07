import 'package:flutter/foundation.dart';

import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';

class KanbanState {
  final List<SectionEntity> sections;
  final List<TaskEntity> tasks;
  final bool isLoading;
  final Failure? loadingFailure;

  const KanbanState({
    required this.sections,
    required this.tasks,
    required this.isLoading,
    required this.loadingFailure,
  });

  factory KanbanState.initial() {
    return const KanbanState(
      sections: [],
      tasks: [],
      isLoading: false,
      loadingFailure: null,
    );
  }

  KanbanState copyWith({
    List<SectionEntity>? sections,
    List<TaskEntity>? tasks,
    bool? isLoading,
    Failure? loadingFailure,
  }) {
    return KanbanState(
      sections: sections ?? this.sections,
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      loadingFailure: loadingFailure ?? this.loadingFailure,
    );
  }

  @override
  bool operator ==(covariant KanbanState other) {
    if (identical(this, other)) return true;

    return listEquals(other.sections, sections) &&
        listEquals(other.tasks, tasks) &&
        other.isLoading == isLoading &&
        other.loadingFailure == loadingFailure;
  }

  @override
  int get hashCode {
    return sections.hashCode ^
        tasks.hashCode ^
        isLoading.hashCode ^
        loadingFailure.hashCode;
  }

  @override
  String toString() {
    return 'KanbanState(sections: $sections, tasks: $tasks, isLoading: $isLoading, loadingFailure: $loadingFailure)';
  }
}
