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
  const blocTestWaitDuration = Duration(milliseconds: 500);

  late MockGetAllSectionsUseCase mockGetAllSectionsUseCase;
  late MockGetAllTasksUseCase mockGetAllTasksUseCase;
  late MockCreateTaskUseCase mockCreateTaskUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;

  late KanbanCubit kanbanCubit;

  setUp(() {
    mockGetAllSectionsUseCase = MockGetAllSectionsUseCase();
    mockGetAllTasksUseCase = MockGetAllTasksUseCase();
    mockCreateTaskUseCase = MockCreateTaskUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();

    kanbanCubit = KanbanCubit(
      getAllSectionsUseCase: mockGetAllSectionsUseCase,
      getAllTasksUseCase: mockGetAllTasksUseCase,
      createTaskUseCase: mockCreateTaskUseCase,
      updateTaskUseCase: mockUpdateTaskUseCase,
      deleteTaskUseCase: mockDeleteTaskUseCase,
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
      projectId: "2203306141",
      sectionId: "7025",
      content: "Buy Milk",
      creatorId: "2671355",
      description: "",
      labels: ["Food", "Shopping"],
      //
      createdAt: DateTime.parse("2019-12-11T22:36:50.000000Z"),
      commentCount: 10,
      isCompleted: false,
      dueString: "tomorrow at 12",
      dueDateTime: DateTime.parse("2019-12-11T22:36:50.000000Z"),
      durationAmount: 15,
      id: "2995104339",
      order: 1,
      priority: 1,
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
      wait: blocTestWaitDuration,
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
      "Should emit [isLoading: true; loadingFailure: ServerFailure], when data fetch is unsuccessful",
      build: () {
        when(mockGetAllTasksUseCase.execute()).thenAnswer((_) async =>
            (null, const ServerFailure(message: "Server failure")));
        return kanbanCubit;
      },
      act: (cubit) => cubit.loadTasks(),
      wait: blocTestWaitDuration,
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
  group("Create a task", () {
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true], and [isLoading: false, tasks [testTaskEntities[0]], when data is fetched",
      build: () {
        when(mockCreateTaskUseCase.execute(task: testTaskEntities[0]))
            .thenAnswer((_) async => (testTaskEntities[0], null));
        return kanbanCubit;
      },
      act: (cubit) => cubit.createTask(task: testTaskEntities[0]),
      wait: blocTestWaitDuration,
      expect: () => [
        const KanbanState(
          sections: [],
          tasks: [],
          isLoading: true,
          loadingFailure: null,
        ),
        KanbanState(
          sections: [],
          tasks: [testTaskEntities[0]],
          isLoading: false,
          loadingFailure: null,
        ),
      ],
    );
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true; loadingFailure: ServerFailure], when data fetch is unsuccessful",
      build: () {
        when(mockCreateTaskUseCase.execute(task: testTaskEntities[0]))
            .thenAnswer((_) async =>
                (null, const ServerFailure(message: "Server failure")));
        return kanbanCubit;
      },
      act: (cubit) => cubit.createTask(task: testTaskEntities[0]),
      wait: blocTestWaitDuration,
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

  group("Update a task", () {
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true], and [isLoading: false, updated tasks list], when data is fetched",
      build: () {
        when(mockUpdateTaskUseCase.execute(task: testTaskEntities[0]))
            .thenAnswer((_) async => (testTaskEntities[0], null));
        // Initial state with the task to be updated
        return kanbanCubit
          ..emit(KanbanState(
            sections: [],
            tasks: [
              testTaskEntities[0].copyWith(content: "Old Content")
            ], // Task with old content
            isLoading: false,
            loadingFailure: null,
          ));
      },
      act: (cubit) => cubit.updateTask(task: testTaskEntities[0]),
      wait: blocTestWaitDuration,
      expect: () => [
        KanbanState(
          sections: [],
          tasks: [
            testTaskEntities[0].copyWith(content: "Old Content")
          ], // Initial state
          isLoading: true,
          loadingFailure: null,
        ),
        KanbanState(
          sections: [],
          tasks: [testTaskEntities[0]], // Updated task list
          isLoading: false,
          loadingFailure: null,
        ),
      ],
    );
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true; loadingFailure: ServerFailure], when data fetch is unsuccessful",
      build: () {
        when(mockUpdateTaskUseCase.execute(task: testTaskEntities[0]))
            .thenAnswer((_) async =>
                (null, const ServerFailure(message: "Server failure")));
        return kanbanCubit
          ..emit(KanbanState(
            sections: [],
            tasks: [
              testTaskEntities[0].copyWith(content: "Old Content")
            ], // Task with old content
            isLoading: false,
            loadingFailure: null,
          ));
        ;
      },
      act: (cubit) => cubit.updateTask(task: testTaskEntities[0]),
      wait: blocTestWaitDuration,
      expect: () => [
        KanbanState(
          sections: [],
          tasks: [testTaskEntities[0].copyWith(content: "Old Content")],
          isLoading: true,
          loadingFailure: null,
        ),
        KanbanState(
          sections: [],
          tasks: [testTaskEntities[0].copyWith(content: "Old Content")],
          isLoading: false,
          loadingFailure: const ServerFailure(message: "Server failure"),
        ),
      ],
    );
  });

  group("Delete a task", () {
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true], and [isLoading: false, tasks list without item], when data is fetched",
      build: () {
        when(mockDeleteTaskUseCase.execute(taskId: testTaskEntities[0].id))
            .thenAnswer((_) async => (true, null));
        // Initial state with the task to be updated
        return kanbanCubit
          ..emit(KanbanState(
            sections: [],
            tasks: [
              testTaskEntities[0],
            ], // Task with old content
            isLoading: false,
            loadingFailure: null,
          ));
      },
      act: (cubit) => cubit.deleteTask(taskId: testTaskEntities[0].id!),
      wait: blocTestWaitDuration,
      expect: () => [
        KanbanState(
          sections: [],
          tasks: [testTaskEntities[0]], // Initial state
          isLoading: true,
          loadingFailure: null,
        ),
        const KanbanState(
          sections: [],
          tasks: [], // Updated task list
          isLoading: false,
          loadingFailure: null,
        ),
      ],
    );
    blocTest<KanbanCubit, KanbanState>(
      "Should emit [isLoading: true; loadingFailure: ServerFailure], when data fetch is unsuccessful",
      build: () {
        when(mockDeleteTaskUseCase.execute(taskId: testTaskEntities[0].id))
            .thenAnswer((_) async =>
                (null, const ServerFailure(message: "Server failure")));
        // Initial state with the task to be updated
        return kanbanCubit
          ..emit(KanbanState(
            sections: [],
            tasks: [
              testTaskEntities[0],
            ], // Task with old content
            isLoading: false,
            loadingFailure: null,
          ));
      },
      act: (cubit) => cubit.deleteTask(taskId: testTaskEntities[0].id!),
      wait: blocTestWaitDuration,
      expect: () => [
        KanbanState(
          sections: [],
          tasks: [testTaskEntities[0]],
          isLoading: true,
          loadingFailure: null,
        ),
        KanbanState(
          sections: [],
          tasks: [testTaskEntities[0]],
          isLoading: false,
          loadingFailure: const ServerFailure(message: "Server failure"),
        ),
      ],
    );
  });
}
