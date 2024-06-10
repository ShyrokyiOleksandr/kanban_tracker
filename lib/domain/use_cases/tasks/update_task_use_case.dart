import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/i_repositories/i_task_repository.dart';

class UpdateTaskUseCase {
  final ITaskRepository _iTaskRepository;

  UpdateTaskUseCase({
    required final ITaskRepository iTaskRepository,
  }) : _iTaskRepository = iTaskRepository;

  Future<(TaskEntity?, Failure?)> execute({
    required TaskEntity task,
  }) async {
    return await _iTaskRepository.updateTask(task: task);
  }
}
