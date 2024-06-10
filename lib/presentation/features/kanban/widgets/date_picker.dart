import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/common/extensions/build_context_extensions.dart';
import 'package:kanban_tracker/presentation/common/widgets/buttons/sheet_header_button.dart';
import 'package:kanban_tracker/presentation/common/widgets/custom_divider.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateSelected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SheetHeaderButton(
                onPressed: Navigator.of(context).pop,
                text: context.strings.actionCancel,
                color: Colors.black87,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  context.strings.selectDateTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SheetHeaderButton(
                onPressed: _selectDate,
                text: context.strings.actionSelect,
                color: Colors.red,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        CustomDivider.horizontal(),
        Padding(
            padding: const EdgeInsets.only(left: 20, top: 28, right: 20),
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: _dateSelected,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime value) {
                  _dateSelected = value;
                },
              ),
            )),
      ],
    );
  }

  void _selectDate() {
    Navigator.of(context).pop(_dateSelected);
  }
}
