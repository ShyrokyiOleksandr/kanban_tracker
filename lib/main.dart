import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/app/kanban_tracker_app.dart';
import 'package:kanban_tracker/service_locator.dart';

void main() async {
  await AppServiceLocator.setup();

  runApp(const KanbanTrackerApp());
}
