import 'package:flutter_boardview/board_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/board/board_model.dart';

class BoardListModel {
  int count;
  List<BoardItemModel> items;
  String name;
  PagingController<int, BoardItem>? pagingController;

  BoardListModel({
    required this.count,
    required this.name,
    required this.items,
    this.pagingController,
  });
}
