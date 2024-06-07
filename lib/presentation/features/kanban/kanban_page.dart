import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/presentation/common/extensions/build_context_extensions.dart';
import 'package:kanban_tracker/presentation/common/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:kanban_tracker/presentation/features/kanban/bloc/kanban_cubit.dart';
import 'package:kanban_tracker/presentation/features/kanban/bloc/kanban_state.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/board/board_card.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/board/board_list_model.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/board/board_model.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/forms/task_form.dart';

class KanbanPage extends StatefulWidget {
  const KanbanPage({super.key});

  @override
  State<KanbanPage> createState() => _KanbanPageState();
}

class _KanbanPageState extends State<KanbanPage> {
  late final _pageBloc = GetIt.I<KanbanCubit>();

  late final BoardViewController _boardViewController;

  List<BoardListModel> _listData = [];

  @override
  void initState() {
    super.initState();

    _boardViewController = BoardViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _createTask,
          icon: const Icon(Icons.add),
        ),
        title: Text(context.strings.appbarTitle),
      ),
      body: BlocBuilder<KanbanCubit, KanbanState>(
        bloc: _pageBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.loadingFailure != null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Error"),
              ),
            );
          } else {
            _listData = _distributeBoardData(
              sections: state.sections,
              tasks: state.tasks,
            );

            List<BoardList> boardLists = [];
            for (int i = 0; i < _listData.length; i++) {
              boardLists.add(_createBoardList(_listData[i]) as BoardList);
            }
            return BoardView(
              boardViewController: _boardViewController,
              lists: boardLists,
            );
          }
        },
      ),
    );
  }

  // TODO: Add sorting and maybe filters
  List<BoardListModel> _distributeBoardData({
    required List<SectionEntity> sections,
    required List<TaskEntity> tasks,
  }) {
    return sections.map((section) {
      final items = tasks
          .where((task) => task.sectionId == section.id)
          .map((task) => BoardItemModel(
                id: int.tryParse(task.id),
                title: task.content,
                subtitle:
                    task.due != null ? task.due!['string'] : 'No due date',
                description: task.description,
              ))
          .toList();

      return BoardListModel(
        name: section.name,
        count: items.length,
        items: items,
      );
    }).toList();
  }

  Widget _createBoardList(BoardListModel list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i]) as BoardItem);
    }

    return BoardList(
      draggable: true,
      onDropList: _handleDropList,
      header: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Badge(
                offset: const Offset(16, -4),
                label: Text("${list.count}"),
                child: Text(list.name,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ],
      items: items,
    );
  }

  Widget buildBoardItem(BoardItemModel itemObject) {
    return BoardItem(
      draggable: true,
      onStartDragItem: (
        int? listIndex,
        int? itemIndex,
        BoardItemState? state,
      ) {},
      onDropItem: (
        int? listIndex,
        int? itemIndex,
        int? oldListIndex,
        int? oldItemIndex,
        BoardItemState? state,
      ) {
        //Used to update our local item data
        var item = _listData[oldListIndex!].items[oldItemIndex!];
        _listData[oldListIndex].items.removeAt(oldItemIndex);
        _listData[listIndex!].items.insert(itemIndex!, item);
      },
      onTapItem: (
        int? listIndex,
        int? itemIndex,
        BoardItemState? state,
      ) async {},
      item: BoardCard(
        item: itemObject,
        onTap: () => _editTask(itemObject),
      ),
    );
  }

  void _handleDropList(int? listIndex, int? oldListIndex) {
    //Update our local list data
    var list = _listData[oldListIndex!];
    _listData.removeAt(oldListIndex);
    _listData.insert(listIndex!, list);
  }

  void _editTask(BoardItemModel itemModel) {
    final result = AppBottomSheet.showModal(
      context: context,
      child: TaskForm(itemModel: itemModel),
      paddingRatio: 0.4,
    );
  }

  void _createTask() {
    final result = AppBottomSheet.showModal(
      context: context,
      child: const TaskForm(),
      paddingRatio: 0.4,
    );
  }
}
