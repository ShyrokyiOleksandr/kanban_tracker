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
      projectId: "2203306141",
      sectionId: "7025",
      content: "Buy Milk",
      description: "",
      labels: ["Food", "Shopping"],
      isCompleted: false,
      order: 1,
      priority: 1,
      due: {
        "datetime": "2019-12-11 22:36:50.000Z",
        "string": "tomorrow at 12",
      },
      duration: {"amount": 15, "unit": "minute"},
      id: "2995104339",
      creatorId: "2671355",
      createdAt: "2019-12-11T22:36:50.000Z",
      commentCount: 10,
      url: "https://todoist.com/showTask?id=2995104339",
    ),
  ];

  // Define a sample TaskEntity object for testing.
  final testTaskEntities = [
    TaskEntity(
      projectId: "2203306141",
      sectionId: "7025",
      content: "Buy Milk",
      description: "",
      labels: ["Food", "Shopping"],
      isCompleted: false,
      order: 1,
      priority: 1,
      dueDateTime: DateTime.tryParse("2019-12-11T22:36:50.000Z"),
      dueString: "tomorrow at 12",
      durationAmount: 15,
      id: "2995104339",
      creatorId: "2671355",
      createdAt: DateTime.tryParse("2019-12-11T22:36:50.000Z"),
      commentCount: 10,
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

  group("Create a task", () {
    test(
      'Should return a  TaskEntity when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.createTask(task: testTaskEntities[0]))
            .thenAnswer((_) async => testTaskModels[0]);

        // act
        final result =
            await taskRepository.createTask(task: testTaskEntities[0]);

        // assert
        expect(result, equals((testTaskEntities[0], null)));
      },
    );

    test(
      'Should return a ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.createTask(task: testTaskEntities[0]))
            .thenThrow(const ServerException(message: 'Failed to load tasks.'));

        // act
        final result =
            await taskRepository.createTask(task: testTaskEntities[0]);

        // assert
        expect(result,
            equals((null, const ServerFailure(message: "Server failure"))));
      },
    );
  });

  group("Update a task", () {
    test(
      'Should return a TaskEntity when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.updateTask(task: testTaskEntities[0]))
            .thenAnswer((_) async => testTaskModels[0]);

        // act
        final result =
            await taskRepository.updateTask(task: testTaskEntities[0]);

        // assert
        expect(result, equals((testTaskEntities[0], null)));
      },
    );

    test(
      'Should return a ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.updateTask(task: testTaskEntities[0]))
            .thenThrow(const ServerException(message: 'Failed to load tasks.'));

        // act
        final result =
            await taskRepository.updateTask(task: testTaskEntities[0]);

        // assert
        expect(result,
            equals((null, const ServerFailure(message: "Server failure"))));
      },
    );
  });

  group("Delete a task", () {
    test(
      'Should return (true, null) when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteTask(taskId: testTaskEntities[0].id))
            .thenAnswer((_) async => true);

        // act
        final result =
            await taskRepository.deleteTask(taskId: testTaskEntities[0].id!);

        // assert
        expect(result, equals((true, null)));
      },
    );

    test(
      'Should return (null, ServerFailure) when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteTask(taskId: testTaskEntities[0].id))
            .thenThrow(const ServerException(message: 'Failed to load tasks.'));

        // act
        final result =
            await taskRepository.deleteTask(taskId: testTaskEntities[0].id!);

        // assert
        expect(result,
            equals((null, const ServerFailure(message: "Server failure"))));
      },
    );
  });
}
