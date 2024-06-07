import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';

abstract interface class ISectionRepository {
  Future<(List<SectionEntity>?, Failure?)> getAllSections();
}
