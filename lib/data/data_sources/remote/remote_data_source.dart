import 'package:dio/dio.dart';
import 'package:kanban_tracker/data/app_services/dio/dio_client_service.dart';
import 'package:kanban_tracker/data/data_sources/remote/app_url_constants.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/data/models/section_model.dart';
import 'package:kanban_tracker/data/models/task_model.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:uuid/uuid.dart';

class RemoteDataSource {
  final DioClientService _dioClientService;
  final Uuid _uuid;

  RemoteDataSource({
    required final DioClientService dioClientService,
    required final Uuid uuid,
  })  : _dioClientService = dioClientService,
        _uuid = uuid;

  Future<List<SectionModel>> getAllSections() async {
    try {
      final response = await _dioClientService.dio.get(
        AppUrlConstants.sections,
        options: Options(
          headers: {'Authorization': 'Bearer ${AppUrlConstants.apiToken}'},
        ),
      );

      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((jsonMap) => SectionModel.fromJson(jsonMap))
            .toList();
      } else {
        throw const ServerException(message: 'Failed to load sections.');
      }
    } on DioException {
      throw const ConnectionException(message: "Connection exception");
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    try {
      final response = await _dioClientService.dio.get(
        AppUrlConstants.tasks,
        options: Options(
          headers: {'Authorization': 'Bearer ${AppUrlConstants.apiToken}'},
        ),
      );

      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((jsonMap) => TaskModel.fromJson(jsonMap))
            .toList();
      } else {
        throw const ServerException(message: 'Failed to load tasks.');
      }
    } on DioException {
      throw const ConnectionException(message: "Connection exception");
    }
  }

  Future<TaskModel> createTask({required TaskEntity task}) async {
    try {
      final response = await _dioClientService.dio.post(
        AppUrlConstants.tasks,
        data: TaskModel.fromDomain(task).toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Request-Id': _uuid.v4(),
            'Authorization': 'Bearer ${AppUrlConstants.apiToken}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return TaskModel.fromJson(response.data);
      } else {
        throw const ServerException(message: 'Failed to load tasks.');
      }
    } on DioException {
      throw const ConnectionException(message: "Connection exception");
    }
  }
}
