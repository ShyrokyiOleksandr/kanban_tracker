import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/data/exceptions/exception.dart';
import 'package:kanban_tracker/data/models/section_model.dart';
import 'package:kanban_tracker/data/repositories/section_repository.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:mockito/mockito.dart';

import '../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late SectionRepository sectionRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    sectionRepository =
        SectionRepository(remoteDataSource: mockRemoteDataSource);
  });

  final testSectionModels = <SectionModel>[
    SectionModel(
      id: "7025",
      projectId: "2203306141",
      order: 1,
      name: "Groceries",
    )
  ];

  final testSectionEntities = <SectionEntity>[
    SectionEntity(
      id: "7025",
      projectId: "2203306141",
      order: 1,
      name: "Groceries",
    )
  ];

  group("Get all sections", () {
    test(
      'Should return a list of TaskEntity when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAllSections())
            .thenAnswer((_) async => testSectionModels);

        // act
        final result = await sectionRepository.getAllSections();

        // assert
        expect(result.$1, equals(testSectionEntities));
        expect(result.$2, equals(null));
      },
    );

    test(
      'Should return a ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAllSections())
            .thenThrow(const ServerException(message: 'Failed to load tasks.'));

        // act
        final result = await sectionRepository.getAllSections();

        // assert
        expect(result.$1, equals(null));
        expect(
          result.$2,
          equals(const ServerFailure(message: "Server failure")),
        );
      },
    );
  });
}
