import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/data/data_sources/remote/app_url_constants.dart';
import 'package:kanban_tracker/data/data_sources/remote/remote_data_source.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/data/models/section_model.dart';
import 'package:kanban_tracker/data/models/task_model.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:mockito/mockito.dart';

import '../../_helpers/dummy_data/dummy_path_constants.dart';
import '../../_helpers/json_reader.dart';
import '../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockDio mockDio;
  late RemoteDataSource remoteDataSource;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = RemoteDataSource(
      apiClient: mockDio,
      isApiClientMocked: true,
    );
  });

  group("Get all sections", () {
    test(
      'Should return List<SectionModel> when response code is 200',
      () async {
        // arrange
        final responseStub =
            '[${readJsonFile(DummyPathConstants.dummySectionResponse)} ]';

        when(mockDio.get(
          AppUrlConstants.sections,
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.sections),
              data: responseStub,
              statusCode: 200,
            ));

        // act
        final result = await remoteDataSource.getAllSections();

        // assert
        expect(result, isA<List<SectionModel>>());
      },
    );

    test(
      'Should throw a ServerException when response code is 404 or other',
      () async {
        // arrange
        when(mockDio.get(
          AppUrlConstants.sections,
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.sections),
              data: 'Not Found',
              statusCode: 404,
            ));

        // act & assert
        expect(
            remoteDataSource.getAllSections(), throwsA(isA<ServerException>()));
      },
    );
  });

  group("Get all tasks", () {
    test(
      'Should return List<TaskModel> when response code is 200',
      () async {
        // arrange
        final responseStub =
            '[${readJsonFile(DummyPathConstants.dummyTaskResponse)} ]';

        when(mockDio.get(
          AppUrlConstants.tasks,
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.tasks),
              data: responseStub,
              statusCode: 200,
            ));

        // act
        final result = await remoteDataSource.getAllTasks();

        // assert
        expect(result, isA<List<TaskModel>>());
      },
    );

    test(
      'Should throw a ServerException when response code is 404 or other',
      () async {
        // arrange
        when(mockDio.get(
          AppUrlConstants.tasks,
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.tasks),
              data: 'Not Found',
              statusCode: 404,
            ));

        // act & assert
        expect(remoteDataSource.getAllTasks(), throwsA(isA<ServerException>()));
      },
    );
  });

  group("Create a task", () {
    final testTaskEntity = TaskEntity(
      creatorId: "2671355",
      createdAt: DateTime.parse("2019-12-11T22:36:50.000000Z"),
      commentCount: 10,
      isCompleted: false,
      content: "Buy Milk",
      description: "",
      dueString: "tomorrow at 12",
      dueDateTime: DateTime.parse("2019-12-11T22:36:50.000000Z"),
      durationAmount: 15,
      id: "2995104339",
      labels: ["Food", "Shopping"],
      order: 1,
      priority: 1,
      projectId: "2203306141",
      sectionId: "7025",
      url: "https://todoist.com/showTask?id=2995104339",
    );
    test(
      'Should return TaskModel when response code is 200',
      () async {
        // arrange
        final responseStub = readJsonFile(DummyPathConstants.dummyTaskResponse);

        when(mockDio.post(
          AppUrlConstants.tasks,
          data: TaskModel.fromDomain(testTaskEntity).toJson(),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.tasks),
              data: responseStub,
              statusCode: 200,
            ));

        // act
        final result = await remoteDataSource.createTask(task: testTaskEntity);

        // assert
        expect(result, isA<TaskModel>());
      },
    );

    test(
      'Should throw a ServerException when response code is 404 or other',
      () async {
        // arrange

        when(mockDio.post(
          AppUrlConstants.tasks,
          data: TaskModel.fromDomain(testTaskEntity).toJson(),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.tasks),
              data: "Not found",
              statusCode: 404,
            ));

        // act & assert
        expect(remoteDataSource.createTask(task: testTaskEntity),
            throwsA(isA<ServerException>()));
      },
    );
  });

  group("Update a task", () {
    final testTaskEntity = TaskEntity(
      creatorId: "2671355",
      createdAt: DateTime.parse("2019-12-11T22:36:50.000000Z"),
      commentCount: 10,
      isCompleted: false,
      content: "Buy Milk",
      description: "",
      dueString: "tomorrow at 12",
      dueDateTime: DateTime.parse("2019-12-11T22:36:50.000000Z"),
      durationAmount: 15,
      id: "2995104339",
      labels: ["Food", "Shopping"],
      order: 1,
      priority: 1,
      projectId: "2203306141",
      sectionId: "7025",
      url: "https://todoist.com/showTask?id=2995104339",
    );
    test(
      'Should return TaskModel when response code is 200',
      () async {
        // arrange
        final responseStub = readJsonFile(DummyPathConstants.dummyTaskResponse);

        when(mockDio.post(
          '${AppUrlConstants.tasks}/${testTaskEntity.id}',
          data: TaskModel.fromDomain(testTaskEntity).toJson(),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.tasks),
              data: responseStub,
              statusCode: 200,
            ));

        // act
        final result = await remoteDataSource.updateTask(task: testTaskEntity);

        // assert
        expect(result, isA<TaskModel>());
      },
    );

    test(
      'Should throw a ServerException when response code is 404 or other',
      () async {
        // arrange

        when(mockDio.post(
          '${AppUrlConstants.tasks}/${testTaskEntity.id}',
          data: TaskModel.fromDomain(testTaskEntity).toJson(),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(
                  path: '${AppUrlConstants.tasks}/${testTaskEntity.id}'),
              data: "Not found",
              statusCode: 404,
            ));

        // act & assert
        expect(remoteDataSource.updateTask(task: testTaskEntity),
            throwsA(isA<ServerException>()));
      },
    );
  });

  group("Delete a task", () {
    const testTaskEntityId = "2995104339";
    test(
      'Should return true when response code is 204',
      () async {
        // arrange
        when(mockDio.delete(
          '${AppUrlConstants.tasks}/$testTaskEntityId',
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(
                  path: '${AppUrlConstants.tasks}/$testTaskEntityId'),
              statusCode: 204,
            ));

        // act
        final result =
            await remoteDataSource.deleteTask(taskId: testTaskEntityId);

        // assert
        expect(result, true);
      },
    );

    test(
      'Should throw a ServerException when response code is 404 or other',
      () async {
        // arrange

        when(mockDio.delete(
          '${AppUrlConstants.tasks}/$testTaskEntityId',
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(
                path: '${AppUrlConstants.tasks}/$testTaskEntityId',
              ),
              data: "Not found",
              statusCode: 404,
            ));

        // act & assert
        expect(remoteDataSource.deleteTask(taskId: testTaskEntityId),
            throwsA(isA<ServerException>()));
      },
    );
  });
}
