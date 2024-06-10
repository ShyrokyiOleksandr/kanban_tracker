import 'package:kanban_tracker/data/data_sources/remote/remote_data_source.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/i_repositories/i_task_repository.dart';

class TaskRepository implements ITaskRepository {
  final RemoteDataSource _remoteDataSource;

  TaskRepository({
    required final RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<(List<TaskEntity>?, Failure?)> getAllTasks() async {
    try {
      final models = await _remoteDataSource.getAllTasks();
      final entities = models.map((model) => model.toDomain()).toList();
      return (entities, null);
    } on ServerException {
      return const (null, ServerFailure(message: "Server failure"));
    } on ConnectionException {
      return const (null, ConnectionFailure(message: "Connection failure"));
    }
  }

  @override
  Future<(TaskEntity?, Failure?)> createTask({required TaskEntity task}) async {
    try {
      final model = await _remoteDataSource.createTask(task: task);
      return (model.toDomain(), null);
    } on ServerException {
      return const (null, ServerFailure(message: "Server failure"));
    } on ConnectionException {
      return const (null, ConnectionFailure(message: "Connection failure"));
    }
  }

  @override
  Future<(TaskEntity?, Failure?)> updateTask({required TaskEntity task}) async {
    try {
      final model = await _remoteDataSource.updateTask(task: task);
      return (model.toDomain(), null);
    } on ServerException {
      return const (null, ServerFailure(message: "Server failure"));
    } on ConnectionException {
      return const (null, ConnectionFailure(message: "Connection failure"));
    }
  }

  @override
  Future<(bool?, Failure?)> deleteTask({required String taskId}) async {
    try {
      final result = await _remoteDataSource.deleteTask(taskId: taskId);
      return (result, null);
    } on ServerException {
      return const (null, ServerFailure(message: "Server failure"));
    } on ConnectionException {
      return const (null, ConnectionFailure(message: "Connection failure"));
    }
  }
}
