import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/update_task_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockITaskRepository mockITaskRepository;
  late UpdateTaskUseCase _updateTaskUseCase;

  setUp(() {
    mockITaskRepository = MockITaskRepository();
    _updateTaskUseCase = UpdateTaskUseCase(
      iTaskRepository: mockITaskRepository,
    );
  });

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
  group("Update a task", () {
    test(
      'Should return (TaskEntity, null) if call to repository is successful',
      () async {
        when(mockITaskRepository.updateTask(task: testTaskEntity))
            .thenAnswer((_) async => (testTaskEntity, null));

        final result = await _updateTaskUseCase.execute(task: testTaskEntity);

        expect(result, (testTaskEntity, null));
      },
    );

    test(
      'Should return (null, ServerFailure) if call to repository is unsuccessful ',
      () async {
        when(mockITaskRepository.updateTask(task: testTaskEntity)).thenAnswer(
            (_) async =>
                (null, const ServerFailure(message: "Server failure")));

        final result = await _updateTaskUseCase.execute(task: testTaskEntity);

        expect(result, (null, const ServerFailure(message: "Server failure")));
      },
    );
  });
}
