import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kanban_tracker/presentation/common/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:kanban_tracker/presentation/common/widgets/buttons/sheet_header_button.dart';
import 'package:kanban_tracker/presentation/common/widgets/custom_divider.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/board/board_model.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/date_picker.dart';

class TaskForm extends StatefulWidget {
  final BoardItemModel? itemModel;

  const TaskForm({
    this.itemModel,
    super.key,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _dueDateController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.itemModel?.title);
    _dueDateController =
        TextEditingController(text: widget.itemModel?.subtitle);
    _descriptionController =
        TextEditingController(text: widget.itemModel?.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dueDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: add l10n
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SheetHeaderButton(
                  onPressed: Navigator.of(context).pop,
                  text: "Close",
                  color: Colors.black87,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.itemModel != null
                        ? "Task #${widget.itemModel!.id.toString()}"
                        : "New task",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SheetHeaderButton(
                  onPressed: _save,
                  text: "Save",
                  color: Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomDivider.horizontal(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    style: Theme.of(context).textTheme.headlineSmall,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                      enabledBorder: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(child: Chip(label: Text("Todo"))),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          onTap: _selectDate,
                          controller: _dueDateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            label: Text("Due date"),
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descriptionController,
                    minLines: 2,
                    maxLines: 7,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectDate() async {
    var result = await AppBottomSheet.showModal(
      context: context,
      child: const DatePicker(),
      paddingRatio: 0.55,
    );

    if (result is DateTime) {
      int currentYear = DateTime.now().year;
      if (result.year > currentYear) {
        // Format with year
        _dueDateController.text = DateFormat('MMM d, yyyy').format(result);
      } else {
        // Format without year
        _dueDateController.text = DateFormat('MMM d').format(result);
      }
    }
  }

  void _save() {}
}
