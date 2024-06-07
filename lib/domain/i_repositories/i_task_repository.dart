import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';

abstract interface class ITaskRepository {
  Future<(List<TaskEntity>?, Failure?)> getAllTasks();

  Future<(TaskEntity?, Failure?)> createTask({required TaskEntity task});
}
