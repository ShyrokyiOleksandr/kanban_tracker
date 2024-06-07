import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/errors/failure.dart';
import 'package:kanban_tracker/domain/use_cases/sections/get_all_sections_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../_helpers/mocks/mock_source.mocks.dart';

void main() {
  late MockISectionRepository mockISectionRepository;
  late GetAllSectionsUseCase getAllSectionsUseCase;

  setUp(() {
    mockISectionRepository = MockISectionRepository();
    getAllSectionsUseCase = GetAllSectionsUseCase(
      iSectionRepository: mockISectionRepository,
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
  group("Get all sections", () {
    test(
      'Should return (List<SectionEntity>, null) if call to repository is successful',
      () async {
        when(mockISectionRepository.getAllSections())
            .thenAnswer((_) async => (testSectionEntities, null));

        final result = await getAllSectionsUseCase.execute();

        expect(result, (testSectionEntities, null));
      },
    );

    test(
      'Should return (null, ServerFailure) if call to repository is unsuccessful ',
      () async {
        when(mockISectionRepository.getAllSections()).thenAnswer((_) async =>
            (null, const ServerFailure(message: "Server failure")));

        final result = await getAllSectionsUseCase.execute();

        expect(result, (null, const ServerFailure(message: "Server failure")));
      },
    );
  });
}
