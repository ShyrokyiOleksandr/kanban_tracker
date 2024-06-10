import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/get_all_tasks_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../_helpers/mocks/mock_source.mocks.dart';

/// This file contains unit tests for the [GetAllTasksUseCase] class.
///
/// It uses the Mockito package to create mock implementations of the [ITaskRepository]
/// interface and verifies that the [GetAllTasksUseCase] correctly interacts with the repository.

void main() {
  late MockITaskRepository mockITaskRepository;
  late GetAllTasksUseCase getAllTasksUseCase;

  /// Sets up the test environment before each test.
  ///
  /// It initializes the [MockITaskRepository] and [GetAllTasksUseCase] instances.
  setUp(() {
    mockITaskRepository = MockITaskRepository();
    getAllTasksUseCase = GetAllTasksUseCase(
      iTaskRepository: mockITaskRepository,
    );
  });

  /// A sample list of [TaskEntity] objects used for testing.
  final testTasks = <TaskEntity>[
    TaskEntity(
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
    )
  ];
  group("Get all tasks", () {
    /// Tests the [GetAllTasksUseCase.execute] method.
    ///
    /// It verifies that the use case retrieves all tasks from the repository and
    /// returns the expected result.
    test(
      'Should return (List<TaskEntity>, null) if call to repository is successful',
      () async {
        // Arrange: Set up the mock repository to return the test tasks.
        when(mockITaskRepository.getAllTasks())
            .thenAnswer((_) async => (testTasks, null));

        // Act: Execute the use case.
        final result = await getAllTasksUseCase.execute();

        // Assert: Verify that the result matches the expected test tasks.
        expect(result, (testTasks, null));
      },
    );

    test(
      'Should return (null, ServerFailure) if call to repository is unsuccessful ',
      () async {
        // Arrange: Set up the mock repository to return the test tasks.
        when(mockITaskRepository.getAllTasks()).thenAnswer((_) async =>
            (null, const ServerFailure(message: "Server failure")));

        // Act: Execute the use case.
        final result = await getAllTasksUseCase.execute();

        // Assert: Verify that the result matches the expected test tasks.
        expect(result, (null, const ServerFailure(message: "Server failure")));
      },
    );
  });
}
