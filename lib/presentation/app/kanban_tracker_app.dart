import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kanban_tracker/presentation/features/main/main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KanbanTrackerApp extends StatefulWidget {
  const KanbanTrackerApp({super.key});

  @override
  State<KanbanTrackerApp> createState() => _KanbanTrackerAppState();
}

class _KanbanTrackerAppState extends State<KanbanTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('uk'), // Spanish
      ],
      home: MainPage(),
    );
  }
}
