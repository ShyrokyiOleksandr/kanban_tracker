import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/data/models/task_model.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';

import '../../_helpers/dummy_data/dummy_path_constants.dart';
import '../../_helpers/json_reader.dart';

void main() {
  final testTaskModel = TaskModel(
    projectId: "2203306141",
    sectionId: "7025",
    content: "Buy Milk",
    description: "",
    labels: ["Food", "Shopping"],
    isCompleted: false,
    order: 1,
    priority: 1,
    due: {
      "datetime": "2019-12-11 22:36:50.000Z",
      "string": "tomorrow at 12",
    },
    duration: {"amount": 15, "unit": "minute"},
    id: "2995104339",
    creatorId: "2671355",
    createdAt: "2019-12-11T22:36:50.000Z",
    commentCount: 10,
    url: "https://todoist.com/showTask?id=2995104339",
  );

  final testTaskEntity = TaskEntity(
    projectId: "2203306141",
    sectionId: "7025",
    content: "Buy Milk",
    description: "",
    labels: ["Food", "Shopping"],
    isCompleted: false,
    order: 1,
    priority: 1,
    dueDateTime: DateTime.tryParse("2019-12-11T22:36:50.000Z"),
    dueString: "tomorrow at 12",
    durationAmount: 15,
    id: "2995104339",
    creatorId: "2671355",
    createdAt: DateTime.tryParse("2019-12-11T22:36:50.000Z"),
    commentCount: 10,
    url: "https://todoist.com/showTask?id=2995104339",
  );

  group("Json related", () {
    test(
      'Should return a valid model from a JSON',
      () async {
        final taskJsonContent =
            readJsonFile(DummyPathConstants.dummyTaskResponse);
        final taskMap = json.decode(taskJsonContent);

        final result = TaskModel.fromJson(taskMap);

        expect(result, equals(testTaskModel));
      },
    );

    // Test case: Verify that a valid JSON representation can be created from a TaskModel object.
    test(
      'Should return a valid JSON from a model',
      () async {
        // Act: Serialize the test TaskModel object into a JSON map.
        final result = testTaskModel.toJson();

        // Arrange: Read the expected JSON data from a file and decode it into a map.
        final taskJsonContent =
            readJsonFile(DummyPathConstants.dummyTaskRequest);
        final expectedTaskMap = json.decode(taskJsonContent);

        // Assert: Verify that the created JSON map matches the expected JSON map.
        expect(result, equals(expectedTaskMap));
      },
    );
  });

  group("Domain related", () {
    test(
      'Should return a valid entity from a model',
      () async {
        //  Arrange & Act: Create a TaskModel object from the decoded JSON map.
        final result = testTaskModel.toDomain();

        // Assert: Verify that the created TaskModel matches the expected test TaskModel.
        expect(result, equals(testTaskEntity));
      },
    );
    test(
      'Should return a valid model from an entity',
      () async {
        //  Arrange & Act: Create a TaskModel object from the decoded JSON map.
        final result = TaskModel.fromDomain(testTaskEntity);

        // Assert: Verify that the created TaskModel matches the expected test TaskModel.
        expect(result, equals(testTaskModel));
      },
    );
  });
}
