import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockITaskRepository mockITaskRepository;
  late CreateTaskUseCase createTaskUseCase;

  setUp(() {
    mockITaskRepository = MockITaskRepository();
    createTaskUseCase = CreateTaskUseCase(
      iTaskRepository: mockITaskRepository,
    );
  });

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
  group("Create a task", () {
    test(
      'Should return (TaskEntity, null) if call to repository is successful',
      () async {
        when(mockITaskRepository.createTask(task: testTaskEntity))
            .thenAnswer((_) async => (testTaskEntity, null));

        final result = await createTaskUseCase.execute(task: testTaskEntity);

        expect(result, (testTaskEntity, null));
      },
    );

    test(
      'Should return (null, ServerFailure) if call to repository is unsuccessful ',
      () async {
        when(mockITaskRepository.createTask(task: testTaskEntity)).thenAnswer(
            (_) async =>
                (null, const ServerFailure(message: "Server failure")));

        final result = await createTaskUseCase.execute(task: testTaskEntity);

        expect(result, (null, const ServerFailure(message: "Server failure")));
      },
    );
  });
}
