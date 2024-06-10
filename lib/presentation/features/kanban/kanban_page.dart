import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:kanban_tracker/data/data_sources/remote/app_url_constants.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart';
import 'package:kanban_tracker/presentation/common/extensions/build_context_extensions.dart';
import 'package:kanban_tracker/presentation/common/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:kanban_tracker/presentation/common/widgets/failure_display.dart';
import 'package:kanban_tracker/presentation/common/widgets/loading_display.dart';
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
            return const LoadingDisplay();
          } else if (state.loadingFailure != null) {
            return FailureDisplay(
              message: state.loadingFailure!.message,
              onPressed: _pageBloc.reloadData,
            );
          } else {
            _listData = _distributeBoardData(
              sections: state.sections,
              tasks: state.tasks,
            );

            List<BoardList> boardLists = [];
            for (int i = 0; i < _listData.length; i++) {
              boardLists.add(
                  _createBoardList(_listData[i], state.sections) as BoardList);
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
                id: task.id ?? "",
                title: task.content,
                subtitle:
                    task.dueString != null ? task.dueString! : 'No due date',
                description: task.description,
                labels: task.labels,
              ))
          .toList();

      return BoardListModel(
        name: section.name,
        count: items.length,
        items: items,
      );
    }).toList();
  }

  Widget _createBoardList(BoardListModel list, List<SectionEntity> sections) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i], sections) as BoardItem);
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

  Widget buildBoardItem(
    BoardItemModel itemObject,
    List<SectionEntity> sections,
  ) {
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
        onTap: () => _updateTask(itemObject, sections),
      ),
    );
  }

  void _handleDropList(int? listIndex, int? oldListIndex) {
    //Update our local list data
    var list = _listData[oldListIndex!];
    _listData.removeAt(oldListIndex);
    _listData.insert(listIndex!, list);
  }

  // TODO: add event to history
  void _createTask() async {
    // TODO: add labels and priority to form
    // TODO: add timer to form
    final result = await AppBottomSheet.showModal<(String, DateTime?, String)?>(
      context: context,
      child: const TaskForm(),
    );

    if (result != null) {
      final task = TaskEntity(
        projectId: AppUrlConstants.projectId,
        sectionId: _pageBloc.state.sections.first.id,
        content: result.$1,
        description: result.$3,
        dueDateTime: result.$2,
        labels: [],
      );
      _pageBloc.createTask(task: task);
    }
  }

  // TODO: add event to history
  void _updateTask(
      BoardItemModel itemModel, List<SectionEntity> sections) async {
    print("sections => $sections");
    final result =
        await AppBottomSheet.showModal<(String?, String, DateTime?, String)?>(
      context: context,
      child: TaskForm(
        itemModel: itemModel,
        sections: sections,
        onDeleteTask: () => _deleteTask(taskId: itemModel.id),
      ),
    );

    if (result != null) {
      SectionEntity? section;
      if (result.$1 != null) {
        section = sections.firstWhere(
          (section) => section.id == result.$1,
          orElse: () => sections.isNotEmpty
              ? sections[0]
              : throw Exception(
                  "No sections available",
                ), // Handle empty sections list
        );
      }

      if (section != null) {
        final task = TaskEntity(
          id: result.$1,
          projectId: AppUrlConstants.projectId,
          sectionId: section.id,
          content: result.$2,
          description: result.$4,
          dueDateTime: result.$3,
          labels: [],
        );
        _pageBloc.updateTask(task: task);
      } else {
        // Handle the case where no section was found
        print('No matching section found for the given section id');
      }
    }
  }

  void _deleteTask({required String taskId}) {
    _pageBloc.deleteTask(taskId: taskId);
  }
}
