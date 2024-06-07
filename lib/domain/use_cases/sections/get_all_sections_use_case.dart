import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/i_repositories/i_section_repository.dart';

class GetAllSectionsUseCase {
  final ISectionRepository _iSectionRepository;

  GetAllSectionsUseCase({
    required final ISectionRepository iSectionRepository,
  }) : _iSectionRepository = iSectionRepository;

  Future<(List<SectionEntity>?, Failure?)> execute() async {
    return await _iSectionRepository.getAllSections();
  }
}
