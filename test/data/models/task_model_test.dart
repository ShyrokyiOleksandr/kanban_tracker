import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_tracker/data/models/task_model.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';

import '../../_helpers/dummy_data/dummy_path_constants.dart';
import '../../_helpers/json_reader.dart';

/// This file contains unit tests for the TaskModel class.
///
/// It verifies that the TaskModel class can correctly serialize and deserialize
/// JSON data, ensuring that the JSON representation of a task model can be
/// converted back and forth between a TaskModel object.
void main() {
  // Define a sample TaskModel object for testing.
  final testTaskModel = TaskModel(
    creatorId: "2671355",
    createdAt: "2019-12-11T22:36:50.000000Z",
    assigneeId: "2671362",
    assignerId: "2671355",
    commentCount: 10,
    isCompleted: false,
    content: "Buy Milk",
    description: "",
    due: {
      "date": "2016-09-01",
      "is_recurring": false,
      "datetime": "2016-09-01T12:00:00.000000Z",
      "string": "tomorrow at 12",
      "timezone": "Europe/Kiev"
    },
    duration: null,
    id: "2995104339",
    labels: ["Food", "Shopping"],
    order: 1,
    priority: 1,
    projectId: "2203306141",
    sectionId: "7025",
    parentId: "2995104589",
    url: "https://todoist.com/showTask?id=2995104339",
  );

  // Define a sample TaskEntity object for testing.
  final testTaskEntity = TaskEntity(
    creatorId: "2671355",
    createdAt: DateTime.parse("2019-12-11T22:36:50.000000Z"),
    assigneeId: "2671362",
    assignerId: "2671355",
    commentCount: 10,
    isCompleted: false,
    content: "Buy Milk",
    description: "",
    due: {
      "date": "2016-09-01",
      "is_recurring": false,
      "datetime": "2016-09-01T12:00:00.000000Z",
      "string": "tomorrow at 12",
      "timezone": "Europe/Kiev"
    },
    duration: null,
    id: "2995104339",
    labels: ["Food", "Shopping"],
    order: 1,
    priority: 1,
    projectId: "2203306141",
    sectionId: "7025",
    parentId: "2995104589",
    url: "https://todoist.com/showTask?id=2995104339",
  );

  group("Json related", () {
    // Test case: Verify that a valid TaskModel object can be created from JSON data.
    test(
      'Should return a valid model from a JSON',
      () async {
        // Arrange: Read the JSON data from a file and decode it into a map.
        final taskJsonContent =
            readJsonFile(DummyPathConstants.dummyTaskResponse);
        final taskMap = json.decode(taskJsonContent);

        // Act: Create a TaskModel object from the decoded JSON map.
        final result = TaskModel.fromJson(taskMap);

        // Assert: Verify that the created TaskModel matches the expected test TaskModel.
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
            readJsonFile(DummyPathConstants.dummyTaskResponse);
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
  });
}
