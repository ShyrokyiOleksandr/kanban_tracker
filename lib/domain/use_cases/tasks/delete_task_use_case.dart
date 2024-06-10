import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/i_repositories/i_task_repository.dart';

class DeleteTaskUseCase {
  final ITaskRepository _iTaskRepository;

  DeleteTaskUseCase({
    required final ITaskRepository iTaskRepository,
  }) : _iTaskRepository = iTaskRepository;

  Future<(bool?, Failure?)> execute({
    required String taskId,
  }) async {
    return await _iTaskRepository.deleteTask(taskId: taskId);
  }
}
