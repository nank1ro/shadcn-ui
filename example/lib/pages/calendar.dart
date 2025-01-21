import 'package:example/common/base_scaffold.dart';
import 'package:example/common/properties/bool_property.dart';
import 'package:example/common/properties/enum_property.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final today = DateTime.now();
  DateTime? selected = DateTime.now();
  bool reverseMonths = false;
  ShadCalendarCaptionLayout captionLayout = ShadCalendarCaptionLayout.label;
  bool hideNavigation = false;
  bool showWeekNumbers = false;
  bool showOutsideDays = true;
  bool fixedWeeks = false;
  bool hideWeekdayNames = false;
  bool allowDeselection = true;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return BaseScaffold(
      appBarTitle: 'Calendar',
      editable: [
        MyBoolProperty(
          label: 'Reverse months',
          value: reverseMonths,
          onChanged: (value) {
            setState(() {
              reverseMonths = value;
            });
          },
        ),
        MyEnumProperty(
          label: 'Caption layout',
          value: captionLayout,
          values: ShadCalendarCaptionLayout.values,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                captionLayout = value;
              });
            }
          },
        ),
        MyBoolProperty(
          label: 'Hide navigation',
          value: hideNavigation,
          onChanged: (value) {
            setState(() {
              hideNavigation = value;
            });
          },
        ),
        MyBoolProperty(
          label: 'Show week numbers',
          value: showWeekNumbers,
          onChanged: (value) {
            setState(() {
              showWeekNumbers = value;
            });
          },
        ),
        MyBoolProperty(
          label: 'Show outside days',
          value: showOutsideDays,
          enabled: !fixedWeeks,
          onChanged: (value) {
            setState(() {
              showOutsideDays = value;
            });
          },
        ),
        MyBoolProperty(
          label: 'Fixed weeks',
          value: fixedWeeks,
          enabled: showOutsideDays,
          onChanged: (value) {
            setState(() {
              fixedWeeks = value;
            });
          },
        ),
        MyBoolProperty(
          label: 'Hide weekday names',
          value: hideWeekdayNames,
          onChanged: (value) {
            setState(() {
              hideWeekdayNames = value;
            });
          },
        ),
        MyBoolProperty(
          label: 'Allow deselection',
          value: allowDeselection,
          onChanged: (value) {
            setState(() {
              allowDeselection = value;
            });
          },
        ),
      ],
      children: [
        Text('Single', style: theme.textTheme.h4),
        ShadCalendar(
          selected: selected,
          fromMonth: DateTime(today.year),
          toMonth: DateTime(today.year, 12),
          hideNavigation: hideNavigation,
          captionLayout: captionLayout,
          onMonthChanged: (date) {
            print('month changed to ${date.month}');
          },
          showWeekNumbers: showWeekNumbers,
          showOutsideDays: showOutsideDays,
          fixedWeeks: fixedWeeks,
          hideWeekdayNames: hideWeekdayNames,
          allowDeselection: allowDeselection,
        ),
        const Divider(),
        Text('Multiple', style: theme.textTheme.h4),
        ShadCalendar.multiple(
          numberOfMonths: 2,
          fromMonth: DateTime(today.year),
          toMonth: DateTime(today.year, 12),
          onChanged: (dates) {},
          min: 5,
          max: 10,
          reverseMonths: reverseMonths,
          hideNavigation: hideNavigation,
          captionLayout: captionLayout,
          showWeekNumbers: showWeekNumbers,
          showOutsideDays: showOutsideDays,
          fixedWeeks: fixedWeeks,
          hideWeekdayNames: hideWeekdayNames,
        ),
        const Divider(),
        Text('Range', style: theme.textTheme.h4),
        ShadCalendar.range(
          onChanged: print,
          min: 2,
          max: 4,
          hideNavigation: hideNavigation,
          captionLayout: captionLayout,
          showWeekNumbers: showWeekNumbers,
          showOutsideDays: showOutsideDays,
          fixedWeeks: fixedWeeks,
          hideWeekdayNames: hideWeekdayNames,
          allowDeselection: allowDeselection,
        ),
      ],
    );
  }
}
