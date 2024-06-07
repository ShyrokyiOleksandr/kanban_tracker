import 'package:kanban_tracker/data/app_services/dio/dio_client_service.dart';
import 'package:kanban_tracker/data/data_sources/remote/remote_data_source.dart';
import 'package:kanban_tracker/domain/i_repositories/i_section_repository.dart';
import 'package:kanban_tracker/domain/i_repositories/i_task_repository.dart';
import 'package:kanban_tracker/domain/use_cases/sections/get_all_sections_use_case.dart';
import 'package:kanban_tracker/domain/use_cases/tasks/get_all_tasks_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    ISectionRepository,
    ITaskRepository,
  ],
  customMocks: [
    MockSpec<GetAllSectionsUseCase>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<GetAllTasksUseCase>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<RemoteDataSource>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<DioClientService>(as: #MockDioClientService),
  ],
)
void main() {}
