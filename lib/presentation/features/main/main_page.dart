import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/features/history/history_page.dart';
import 'package:kanban_tracker/presentation/features/kanban/kanban_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final _bottomNavigationColor = Colors.black;

  final List<Widget> _examples = [
    const KanbanPage(),
    const HistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _examples[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: _bottomNavigationColor,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_on, color: _bottomNavigationColor),
              label: "Kanban",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history, color: _bottomNavigationColor),
              label: "History",
            ),
          ],
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
