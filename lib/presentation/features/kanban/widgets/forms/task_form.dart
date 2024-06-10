import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kanban_tracker/domain/entities/section_entity.dart';
import 'package:kanban_tracker/presentation/common/extensions/build_context_extensions.dart';
import 'package:kanban_tracker/presentation/common/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:kanban_tracker/presentation/common/widgets/buttons/sheet_header_button.dart';
import 'package:kanban_tracker/presentation/common/widgets/custom_divider.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/board/board_model.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/date_picker.dart';

class TaskForm extends StatefulWidget {
  final BoardItemModel? itemModel;
  final List<SectionEntity>? sections;
  final VoidCallback? onDeleteTask;

  const TaskForm({
    this.itemModel,
    this.sections,
    this.onDeleteTask,
    super.key,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TextEditingController _titleController;
  String? _titleErrorText;

  late final TextEditingController _dueDateController;
  DateTime? _dueDate;

  late final TextEditingController _descriptionController;

  late String _section = '';

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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SheetHeaderButton(
                      onPressed: Navigator.of(context).pop,
                      text: widget.itemModel != null
                          ? context.strings.actionClose
                          : context.strings.actionCancel,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          widget.itemModel != null
                              ? "${context.strings.prefixTask} #${widget.itemModel!.id.toString()}"
                              : context.strings.textNewTask,
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SheetHeaderButton(
                      onPressed: _save,
                      text: context.strings.actionSave,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomDivider.horizontal(),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    style: Theme.of(context).textTheme.headlineSmall,
                    decoration: InputDecoration(
                      label: Text(context.strings.fieldTitleTitle),
                      errorText: _titleErrorText,
                    ),
                    minLines: 1,
                    maxLines: 2,
                    onChanged: (_) => _validateTitle(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // TODO: Call bottom sheet to change status
                      Chip(label: Text(_section)),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          onTap: _selectDate,
                          controller: _dueDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text(context.strings.fieldTitleDueDate),
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
                    decoration: InputDecoration(
                      label: Text(context.strings.fieldTitleDescription),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (widget.onDeleteTask != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                          onPressed: () async {
                            final result = await showCupertinoModalPopup<bool?>(
                                context: context,
                                builder: (builderContext) {
                                  return CupertinoActionSheet(
                                    title: Text(
                                      "${context.strings.actionDelete} "
                                      "${context.strings.prefixTask} "
                                      "${widget.itemModel?.id}?",
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                        onPressed: () =>
                                            Navigator.of(builderContext)
                                                .pop(true),
                                        child: Text(
                                          context.strings.actionDelete,
                                        ),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () =>
                                            Navigator.of(builderContext).pop(),
                                        child: Text(
                                          context.strings.actionCancel,
                                        ),
                                      ),
                                    ],
                                  );
                                });
                            if (result == true) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context).pop();
                                widget.onDeleteTask!();
                              });
                            }
                          },
                          label: Text(
                            context.strings.actionDelete,
                            style: const TextStyle(color: Colors.red),
                          ),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
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
    var result = await AppBottomSheet.showModal<DateTime?>(
      context: context,
      child: const DatePicker(),
      paddingRatio: 0.55,
    );

    if (result != null) {
      int currentYear = DateTime.now().year;
      if (result.year > currentYear) {
        // Format with year
        _dueDateController.text = DateFormat('MMM d, yyyy').format(result);
        _dueDate = result;
      } else {
        // Format without year
        _dueDateController.text = DateFormat('MMM d').format(result);
        _dueDate = result;
      }
    }
  }

  void _validateTitle() {
    if (_titleController.text.isEmpty) {
      setState(() => _titleErrorText = context.strings.validationFieldNotEmpty);
    } else {
      setState(() => _titleErrorText = null);
    }
  }

  void _save() {
    _validateTitle();

    if (_titleErrorText == null) {
      if (widget.itemModel != null) {
        Navigator.of(context).pop((
          widget.itemModel?.id,
          _titleController.text,
          _dueDate,
          _descriptionController.text,
        ));
      } else {
        Navigator.of(context).pop((
          _titleController.text,
          _dueDate,
          _descriptionController.text,
        ));
      }
    }
  }
}
