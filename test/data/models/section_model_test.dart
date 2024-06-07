import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/data/models/section_model.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';

import '../../_helpers/dummy_data/dummy_path_constants.dart';
import '../../_helpers/json_reader.dart';

void main() {
  final testSectionModel = SectionModel(
    id: "7025",
    projectId: "2203306141",
    order: 1,
    name: "Groceries",
  );

  final testTaskEntity = SectionEntity(
    id: "7025",
    projectId: "2203306141",
    order: 1,
    name: "Groceries",
  );

  group("Json related", () {
    test(
      'Should return a valid model from a JSON',
      () async {
        final sectionJsonContent =
            readJsonFile(DummyPathConstants.dummySectionResponse);
        final sectionMap = json.decode(sectionJsonContent);

        final result = SectionModel.fromJson(sectionMap);

        expect(result, equals(testSectionModel));
      },
    );

    test(
      'Should return a valid JSON from a model',
      () async {
        final result = testSectionModel.toJson();

        final sectionJsonContent =
            readJsonFile(DummyPathConstants.dummySectionResponse);
        final expectedSectionMap = json.decode(sectionJsonContent);

        expect(result, equals(expectedSectionMap));
      },
    );
  });

  group("Domain related", () {
    test(
      'Should return a valid entity from a model',
      () async {
        final result = testSectionModel.toDomain();

        expect(result, equals(testTaskEntity));
      },
    );
  });
}
