import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/delete_task_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockITaskRepository mockITaskRepository;
  late DeleteTaskUseCase deleteTaskUseCase;

  setUp(() {
    mockITaskRepository = MockITaskRepository();
    deleteTaskUseCase = DeleteTaskUseCase(
      iTaskRepository: mockITaskRepository,
    );
  });

  const testTaskEntityId = "2995104339";
  group("Delete a task", () {
    test(
      'Should return (true, null) if call to repository is successful',
      () async {
        when(mockITaskRepository.deleteTask(taskId: testTaskEntityId))
            .thenAnswer((_) async => (true, null));

        final result =
            await deleteTaskUseCase.execute(taskId: testTaskEntityId);

        expect(result, (true, null));
      },
    );

    test(
      'Should return (null, ServerFailure) if call to repository is unsuccessful ',
      () async {
        when(mockITaskRepository.deleteTask(taskId: testTaskEntityId))
            .thenAnswer((_) async =>
                (null, const ServerFailure(message: "Server failure")));

        final result =
            await deleteTaskUseCase.execute(taskId: testTaskEntityId);

        expect(result, (null, const ServerFailure(message: "Server failure")));
      },
    );
  });
}
