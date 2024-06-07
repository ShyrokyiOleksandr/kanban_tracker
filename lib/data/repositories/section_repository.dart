import 'package:kanban_tracker/data/data_sources/remote/remote_data_source.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/i_repositories/i_section_repository.dart';

class SectionRepository implements ISectionRepository {
  final RemoteDataSource _remoteDataSource;

  SectionRepository({
    required final RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<(List<SectionEntity>?, Failure?)> getAllSections() async {
    try {
      final models = await _remoteDataSource.getAllSections();
      final entities = models.map((model) => model.toDomain()).toList();
      return (entities, null);
    } on ServerException {
      return const (null, ServerFailure(message: "Server failure"));
    } on ConnectionException {
      return const (null, ConnectionFailure(message: "Connection failure"));
    }
  }
}
