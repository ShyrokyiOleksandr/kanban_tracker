import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kanban_tracker/data/data_sources/remote/app_url_constants.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/data/models/section_model.dart';
import 'package:kanban_tracker/data/models/task_model.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:uuid/uuid.dart';

class RemoteDataSource {
  static const _connectTimeout = Duration(milliseconds: 10000);
  static const _receiveTimeout = Duration(milliseconds: 10000);

  final Dio _apiClient;
  final Uuid _uuid = const Uuid();

  RemoteDataSource({
    required Dio apiClient,
    bool isApiClientMocked = false,
  }) : _apiClient = apiClient {
    if (!isApiClientMocked) {
      _apiClient.options = BaseOptions(
          connectTimeout: _connectTimeout, receiveTimeout: _receiveTimeout);
      _apiClient.interceptors
          .add(LogInterceptor(request: true, responseBody: true));
    }
  }

  Future<List<SectionModel>> getAllSections() async {
    try {
      final response = await _apiClient.get(
        AppUrlConstants.sections,
        options: Options(
          headers: {'Authorization': 'Bearer ${AppUrlConstants.apiToken}'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        List<dynamic> jsonData;

        if (data is String) {
          jsonData = json.decode(data) as List<dynamic>;
        } else {
          jsonData = data as List<dynamic>;
        }

        return jsonData
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
      final response = await _apiClient.get(
        AppUrlConstants.tasks,
        options: Options(
          headers: {'Authorization': 'Bearer ${AppUrlConstants.apiToken}'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        List<dynamic> jsonData;

        if (data is String) {
          jsonData = json.decode(data) as List<dynamic>;
        } else {
          jsonData = data as List<dynamic>;
        }

        return jsonData.map((jsonMap) => TaskModel.fromJson(jsonMap)).toList();
      } else {
        throw const ServerException(message: 'Failed to load tasks.');
      }
    } on DioException {
      throw const ConnectionException(message: "Connection exception");
    }
  }

  Future<TaskModel> createTask({required TaskEntity task}) async {
    try {
      final response = await _apiClient.post(
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
        // Check the type of response.data and decode accordingly
        final responseData = response.data;
        if (responseData is String) {
          return TaskModel.fromJson(json.decode(responseData));
        } else if (responseData is Map<String, dynamic>) {
          return TaskModel.fromJson(responseData);
        } else {
          throw const ServerException(message: 'Invalid response format.');
        }
      } else {
        throw const ServerException(message: 'Failed to load tasks.');
      }
    } on DioException {
      throw const ConnectionException(message: "Connection exception");
    }
  }

  Future<TaskModel> updateTask({required TaskEntity task}) async {
    try {
      final response = await _apiClient.post(
        '${AppUrlConstants.tasks}/${task.id}',
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
        // Check the type of response.data and decode accordingly
        final responseData = response.data;
        if (responseData is String) {
          return TaskModel.fromJson(json.decode(responseData));
        } else if (responseData is Map<String, dynamic>) {
          return TaskModel.fromJson(responseData);
        } else {
          throw const ServerException(message: 'Invalid response format.');
        }
      } else {
        throw const ServerException(message: 'Failed to load tasks.');
      }
    } on DioException {
      throw const ConnectionException(message: "Connection exception");
    }
  }

  Future<bool?> deleteTask({required String taskId}) async {
    try {
      final response = await _apiClient.delete(
        '${AppUrlConstants.tasks}/$taskId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppUrlConstants.apiToken}',
          },
        ),
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw const ServerException(message: 'Failed to load tasks.');
      }
    } on DioException {
      throw const ConnectionException(message: "Connection exception");
    }
  }
}
