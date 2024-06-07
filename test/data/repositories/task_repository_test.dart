import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/data/models/task_model.dart';
import 'package:kanban_tracker/data/repositories/task_repository.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:mockito/mockito.dart';

import '../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late TaskRepository taskRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    taskRepository = TaskRepository(remoteDataSource: mockRemoteDataSource);
  });

  // Define a sample TaskModel object for testing.
  final testTaskModels = [
    TaskModel(
      creatorId: "2671355",
      createdAt: "2019-12-11T22:36:50.000000Z",
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
    ),
  ];

  // Define a sample TaskEntity object for testing.
  final testTaskEntities = [
    TaskEntity(
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
    ),
  ];

  group("Get all tasks", () {
    test(
      'Should return a list of TaskEntity when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAllTasks())
            .thenAnswer((_) async => testTaskModels);

        // act
        final result = await taskRepository.getAllTasks();

        // assert
        expect(result.$1, equals(testTaskEntities));
        expect(result.$2, equals(null));
      },
    );

    test(
      'Should return a ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAllTasks())
            .thenThrow(const ServerException(message: 'Failed to load tasks.'));

        // act
        final result = await taskRepository.getAllTasks();

        // assert
        expect(result.$1, equals(null));
        expect(
          result.$2,
          equals(const ServerFailure(message: "Server failure")),
        );
      },
    );
  });
}
