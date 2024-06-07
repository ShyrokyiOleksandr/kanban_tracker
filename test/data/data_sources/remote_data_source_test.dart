import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/data/data_sources/remote/app_url_constants.dart';
import 'package:kanban_tracker/data/data_sources/remote/remote_data_source.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/data/models/section_model.dart';
import 'package:kanban_tracker/data/models/task_model.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import '../../_helpers/dummy_data/dummy_path_constants.dart';
import '../../_helpers/json_reader.dart';
import '../../_helpers/mocks/mock_source.mocks.dart';

// TODO: Fix "FakeUsedError: 'dio' No stub was found which matches the argument of  method call"
void main() {
  late MockDioClientService mockDioService;
  late Uuid uuid;
  late RemoteDataSource remoteDataSource;

  setUp(() {
    mockDioService = MockDioClientService();
    uuid = const Uuid();
    remoteDataSource = RemoteDataSource(
      dioClientService: mockDioService,
      uuid: uuid,
    );
  });

  group("Get all sections", () {
    test(
      'Should return List<SectionModel> when response code is 200',
      () async {
        // arrange
        final responseStub =
            '[${readJsonFile(DummyPathConstants.dummySectionResponse)} ]';

        when(mockDioService.dio.get(
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
        when(mockDioService.dio.get(
          AppUrlConstants.sections,
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.sections),
              data: 'Not Found',
              statusCode: 200,
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

        when(mockDioService.dio.get(
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
        when(mockDioService.dio.get(
          AppUrlConstants.tasks,
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.tasks),
              data: 'Not Found',
              statusCode: 200,
            ));

        // act & assert
        expect(remoteDataSource.getAllTasks(), throwsA(isA<ServerException>()));
      },
    );
  });

  group("Create task", () {
    final testTaskEntity = TaskEntity(
      creatorId: "2671355",
      createdAt: DateTime.parse("2019-12-11T22:36:50.000000Z"),
      assigneeId: "2671362",
      assignerId: "2671355",
      commentCount: 10,
      isCompleted: false,
      content: "Buy Milk",
      description: "",
      due: {
        "date": "2016-09-01",
        "isRecurring": false,
        "datetime": "2016-09-01T12:00:00.000000Z",
        "string": "tomorrow at 12",
        "timezone": "Europe/Kiev"
      },
      duration: null,
      id: "2995104339",
      labels: ["Food", "Shopping"],
      order: 1,
      priority: 1,
      projectId: "2203306141",
      sectionId: "7025",
      parentId: "2995104589",
      url: "https://todoist.com/showTask?id=2995104339",
    );
    test(
      'Should return TaskModel when response code is 200',
      () async {
        // arrange
        final responseStub = readJsonFile(DummyPathConstants.dummyTaskResponse);

        when(mockDioService.dio.post(
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
        expect(result, isA<List<TaskModel>>());
      },
    );

    test(
      'Should throw a ServerException when response code is 404 or other',
      () async {
        // arrange
        when(mockDioService.dio.get(
          AppUrlConstants.tasks,
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response<dynamic>(
              requestOptions: RequestOptions(path: AppUrlConstants.tasks),
              data: 'Not Found',
              statusCode: 200,
            ));

        // act & assert
        expect(remoteDataSource.getAllTasks(), throwsA(isA<ServerException>()));
      },
    );
  });
}
