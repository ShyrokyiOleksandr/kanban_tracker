import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/i_repositories/i_task_repository.dart';

class GetAllTasksUseCase {
  final ITaskRepository _iTaskRepository;

  GetAllTasksUseCase({
    required final ITaskRepository iTaskRepository,
  }) : _iTaskRepository = iTaskRepository;

  Future<(List<TaskEntity>?, Failure?)> execute() async {
    return await _iTaskRepository.getAllTasks();
  }
}
