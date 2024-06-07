import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/presentation/features/kanban/bloc/kanban_cubit.dart';
import 'package:kanban_tracker/presentation/features/kanban/bloc/kanban_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockGetAllSectionsUseCase mockGetAllSectionsUseCase;
  late MockGetAllTasksUseCase mockGetAllTasksUseCase;
  late KanbanCubit kanbanCubit;

  setUp(() {
    mockGetAllSectionsUseCase = MockGetAllSectionsUseCase();
    mockGetAllTasksUseCase = MockGetAllTasksUseCase();
    kanbanCubit = KanbanCubit(
      getAllSectionsUseCase: mockGetAllSectionsUseCase,
      getAllTasksUseCase: mockGetAllTasksUseCase,
    );
  });

  final testSectionEntities = <SectionEntity>[
    SectionEntity(
      id: "7025",
      projectId: "2203306141",
      order: 1,
      name: "Groceries",
    )
  ];

  /// A sample list of [TaskEntity] objects used for testing.
  final testTaskEntities = <TaskEntity>[
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
    )
  ];

  group("Get all sections", () {
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true; isLoading: false], when data is fetched",
      build: () {
        when(mockGetAllSectionsUseCase.execute())
            .thenAnswer((_) async => (testSectionEntities, null));
        return kanbanCubit;
      },
      act: (cubit) => cubit.loadSections(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const KanbanState(
          sections: [],
          tasks: [],
          isLoading: true,
          loadingFailure: null,
        ),
        KanbanState(
          sections: testSectionEntities,
          tasks: [],
          isLoading: false,
          loadingFailure: null,
        ),
      ],
    );
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true; loadingFailure: ServerFailure], when data is fetched",
      build: () {
        when(mockGetAllTasksUseCase.execute()).thenAnswer((_) async =>
            (null, const ServerFailure(message: "Server failure")));
        return kanbanCubit;
      },
      act: (cubit) => cubit.loadTasks(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const KanbanState(
          sections: [],
          tasks: [],
          isLoading: true,
          loadingFailure: null,
        ),
        const KanbanState(
          sections: [],
          tasks: [],
          isLoading: false,
          loadingFailure: ServerFailure(message: "Server failure"),
        ),
      ],
    );
  });
  group("Get all tasks", () {
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true; isLoading: false], when data is fetched",
      build: () {
        when(mockGetAllTasksUseCase.execute())
            .thenAnswer((_) async => (testTaskEntities, null));
        return kanbanCubit;
      },
      act: (cubit) => cubit.loadTasks(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const KanbanState(
          sections: [],
          tasks: [],
          isLoading: true,
          loadingFailure: null,
        ),
        KanbanState(
          sections: [],
          tasks: testTaskEntities,
          isLoading: false,
          loadingFailure: null,
        ),
      ],
    );
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true; loadingFailure: ServerFailure], when data is fetched",
      build: () {
        when(mockGetAllTasksUseCase.execute()).thenAnswer((_) async =>
            (null, const ServerFailure(message: "Server failure")));
        return kanbanCubit;
      },
      act: (cubit) => cubit.loadTasks(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const KanbanState(
          sections: [],
          tasks: [],
          isLoading: true,
          loadingFailure: null,
        ),
        const KanbanState(
          sections: [],
          tasks: [],
          isLoading: false,
          loadingFailure: ServerFailure(message: "Server failure"),
        ),
      ],
    );
  });
}
