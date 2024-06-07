import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_tracker/domain/use_cases/sections/get_all_sections_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/get_all_tasks_use_case.dart';
import 'package:kanban_tracker/presentation/features/kanban/bloc/kanban_state.dart';

final class KanbanCubit extends Cubit<KanbanState> {
  final GetAllTasksUseCase _getAllTasksUseCaseGe;
  final GetAllSectionsUseCase _getAllSectionsUseCase;

  KanbanCubit({
    required final GetAllTasksUseCase getAllTasksUseCase,
    required final GetAllSectionsUseCase getAllSectionsUseCase,
  })  : _getAllTasksUseCaseGe = getAllTasksUseCase,
        _getAllSectionsUseCase = getAllSectionsUseCase,
        super(KanbanState.initial()) {
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
}
