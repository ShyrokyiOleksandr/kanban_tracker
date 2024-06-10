import 'package:dio/dio.dart';
import 'package:kanban_tracker/data/data_sources/remote/remote_data_source.dart';
import 'package:kanban_tracker/domain/i_repositories/i_section_repository.dart';
import 'package:kanban_tracker/domain/i_repositories/i_task_repository.dart';
import 'package:kanban_tracker/domain/use_cases/sections/get_all_sections_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/create_task_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/delete_task_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/get_all_tasks_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/update_task_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    ISectionRepository,
    ITaskRepository,
    RemoteDataSource,
    Dio,
  ],
  customMocks: [
    MockSpec<GetAllSectionsUseCase>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<GetAllTasksUseCase>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<CreateTaskUseCase>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<UpdateTaskUseCase>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<DeleteTaskUseCase>(onMissingStub: OnMissingStub.returnDefault),
  ],
)
void main() {}
