import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/domain/use_cases/sections/get_all_sections_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/delete_task_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/get_all_tasks_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/update_task_use_case.dart';
import 'package:kanban_tracker/presentation/features/kanban/bloc/kanban_state.dart';

final class KanbanCubit extends Cubit<KanbanState> {
  final GetAllSectionsUseCase _getAllSectionsUseCase;
  final GetAllTasksUseCase _getAllTasksUseCaseGe;
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  KanbanCubit({
    required final GetAllSectionsUseCase getAllSectionsUseCase,
    required final GetAllTasksUseCase getAllTasksUseCase,
    required final CreateTaskUseCase createTaskUseCase,
    required final UpdateTaskUseCase updateTaskUseCase,
    required final DeleteTaskUseCase deleteTaskUseCase,
  })  : _getAllSectionsUseCase = getAllSectionsUseCase,
        _getAllTasksUseCaseGe = getAllTasksUseCase,
        _createTaskUseCase = createTaskUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        super(KanbanState.initial()) {
    loadSections();
    loadTasks();
  }

  void reloadData() {
    emit(KanbanState.initial());
    loadSections();
    loadTasks();
  }

  void loadSections() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllSectionsUseCase.execute();
    if (result.$1 != null) {
      emit(state.copyWith(isLoading: false, sections: result.$1));
    } else {
      emit(state.copyWith(isLoading: false, loadingFailure: result.$2));
    }
  }

  void loadTasks() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllTasksUseCaseGe.execute();
    if (result.$1 != null) {
      emit(state.copyWith(isLoading: false, tasks: result.$1));
    } else {
      emit(state.copyWith(isLoading: false, loadingFailure: result.$2));
    }
  }

  void createTask({required TaskEntity task}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createTaskUseCase.execute(task: task);
    if (result.$1 != null) {
      emit(state
          .copyWith(isLoading: false, tasks: [...state.tasks, result.$1!]));
    } else {
      emit(state.copyWith(isLoading: false, loadingFailure: result.$2));
    }
  }

  void updateTask({required TaskEntity task}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _updateTaskUseCase.execute(task: task);
    if (result.$1 != null) {
      final updatedTaskIndex = state.tasks
          .indexWhere((task) => task.id != null && task.id == result.$1!.id);
      if (updatedTaskIndex != -1) {
        final updatedList = [...state.tasks];
        updatedList[updatedTaskIndex] = result.$1!;
        emit(state.copyWith(isLoading: false, tasks: updatedList));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } else {
      emit(state.copyWith(isLoading: false, loadingFailure: result.$2));
    }
  }

  void deleteTask({required String taskId}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteTaskUseCase.execute(taskId: taskId);
    if (result.$1 == true) {
      final deletedTaskIndex = state.tasks
          .indexWhere((task) => task.id != null && task.id == taskId);
      if (deletedTaskIndex != -1) {
        final updatedList = [...state.tasks];
        updatedList.removeAt(deletedTaskIndex);
        emit(state.copyWith(isLoading: false, tasks: updatedList));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } else {
      emit(state.copyWith(isLoading: false, loadingFailure: result.$2));
    }
  }
}
