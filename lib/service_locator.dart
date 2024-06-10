import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kanban_tracker/data/data_sources/remote/remote_data_source.dart';
import 'package:kanban_tracker/data/repositories/section_repository.dart';
import 'package:kanban_tracker/data/repositories/task_repository.dart';
import 'package:kanban_tracker/domain/use_cases/sections/get_all_sections_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/delete_task_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/get_all_tasks_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/update_task_use_case.dart';
import 'package:kanban_tracker/presentation/features/kanban/bloc/kanban_cubit.dart';

final getIt = GetIt.instance;

final class AppServiceLocator {
  static Future<void> setup() async {
    // services
    GetIt.I.registerLazySingleton<Dio>(
      () => Dio(),
    );

    // data sources
    GetIt.I.registerLazySingleton(
      () => RemoteDataSource(apiClient: GetIt.I<Dio>()),
    );

    // repositories
    GetIt.I.registerLazySingleton(
      () => SectionRepository(remoteDataSource: GetIt.I<RemoteDataSource>()),
    );
    GetIt.I.registerLazySingleton(
      () => TaskRepository(remoteDataSource: GetIt.I<RemoteDataSource>()),
    );

    // use cases
    GetIt.I.registerLazySingleton(
      () => GetAllSectionsUseCase(
          iSectionRepository: GetIt.I<SectionRepository>()),
    );
    GetIt.I.registerLazySingleton(
      () => GetAllTasksUseCase(iTaskRepository: GetIt.I<TaskRepository>()),
    );
    GetIt.I.registerLazySingleton(
      () => CreateTaskUseCase(iTaskRepository: GetIt.I<TaskRepository>()),
    );
    GetIt.I.registerLazySingleton(
      () => UpdateTaskUseCase(iTaskRepository: GetIt.I<TaskRepository>()),
    );
    GetIt.I.registerLazySingleton(
      () => DeleteTaskUseCase(iTaskRepository: GetIt.I<TaskRepository>()),
    );

    // blocs
    GetIt.I.registerLazySingleton(
      () => KanbanCubit(
        getAllSectionsUseCase: GetIt.I<GetAllSectionsUseCase>(),
        getAllTasksUseCase: GetIt.I<GetAllTasksUseCase>(),
        createTaskUseCase: GetIt.I<CreateTaskUseCase>(),
        updateTaskUseCase: GetIt.I<UpdateTaskUseCase>(),
        deleteTaskUseCase: GetIt.I<DeleteTaskUseCase>(),
      ),
    );
  }

  const AppServiceLocator._();
}
