import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shadcn_ui/src/components/button.dart';
import 'package:shadcn_ui/src/components/select.dart';
import 'package:shadcn_ui/src/theme/components/decorator.dart';
import 'package:shadcn_ui/src/theme/theme.dart';
import 'package:shadcn_ui/src/utils/border.dart';
import 'package:shadcn_ui/src/utils/extensions/date_time.dart';

/// Encapsulates a start and end [DateTime] that represent the range of dates.
///
/// The range includes the [start] and [end] dates. The [start] and [end] dates
/// may be equal to indicate a date range of a single day. The [start] date must
/// not be after the [end] date.
@immutable
class ShadDateTimeRange {
  /// Creates a date range for the given start and end [DateTime].
  const ShadDateTimeRange({
    this.start,
    this.end,
  });

  /// The start of the range of dates.
  final DateTime? start;

  /// The end of the range of dates.
  final DateTime? end;

  /// Returns a [Duration] of the time between [start] and [end].
  ///
  /// See [DateTime.difference] for more details.
  Duration? get duration =>
      start == null || end == null ? null : end!.difference(start!);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DateTimeRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hashAll([start, end]);

  @override
  String toString() => 'ShadDateTimeRange(start: $start, end $end)';
}

@immutable
class ShadCalendarModel {
  const ShadCalendarModel({
    required this.month,
    required this.dates,
    required this.firstDateShown,
  });

  final DateTime month;
  final List<DateTime?> dates;
  final DateTime firstDateShown;

  @override
  int get hashCode => Object.hashAll([month, dates, firstDateShown]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShadCalendarModel &&
        other.month == month &&
        listEquals(other.dates, dates) &&
        other.firstDateShown == firstDateShown;
  }
}

enum ShadCalendarVariant { single, multiple, range }

enum ShadCalendarCaptionLayout {
  /// Displays the month and year as a label. Default value.
  label,

  /// Displays a dropdown with both months and years.
  dropdown,

  /// Displays a dropdown with the months only.
  dropdownMonths,

  /// Displays a dropdown with the years only.
  dropdownYears,
}

class ShadCalendar extends StatefulWidget {
  const ShadCalendar({
    super.key,
    this.selected,
    this.onChanged,
    this.showOutsideDays,
    this.initialMonth,
    this.formatMonthYear,
    this.formatMonth,
    this.formatYear,
    this.formatWeekday,
    this.showWeekNumbers,
    this.weekStartsOn,
    this.fixedWeeks,
    this.hideWeekdayNames,
    this.numberOfMonths = 1,
    this.fromMonth,
    this.toMonth,
    this.onMonthChanged,
    this.reverseMonths = false,
    this.selectableDayPredicate,
    this.captionLayout,
    this.hideNavigation,
    this.yearSelectorMinWidth,
    this.monthSelectorMinWidth,
    this.yearSelectorPadding,
    this.monthSelectorPadding,
    this.navigationButtonSize,
    this.navigationButtonIconSize,
    this.backNavigationButtonIconData,
    this.forwardNavigationButtonIconData,
    this.navigationButtonPadding,
    this.navigationButtonDisabledOpacity,
    this.decoration,
    this.spacingBetweenMonths,
    this.runSpacingBetweenMonths,
    this.monthConstraints,
    this.headerHeight,
    this.headerPadding,
    this.captionLayoutGap,
    this.headerTextStyle,
    this.weekdaysPadding,
    this.weekdaysTextStyle,
    this.weekdaysTextAlign,
    this.weekNumbersHeaderText,
    this.weekNumbersHeaderTextStyle,
    this.weekNumbersTextStyle,
    this.weekNumbersTextAlign,
    this.dayButtonSize,
    this.dayButtonOutsideMonthOpacity,
    this.dayButtonPadding,
    this.dayButtonDecoration,
    this.selectedDayButtonTextStyle,
    this.insideRangeDayButtonTextStyle,
    this.dayButtonTextStyle,
    this.dayButtonVariant,
    this.selectedDayButtonVariant,
    this.insideRangeDayButtonVariant,
    this.todayButtonVariant,
    this.gridMainAxisSpacing,
    this.gridCrossAxisSpacing,
    this.dayButtonOutsideMonthTextStyle,
    this.dayButtonOutsideMonthVariant,
    this.selectedDayButtonOusideMonthVariant,
    this.allowDeselection,
  })  : variant = ShadCalendarVariant.single,
        multipleSelected = null,
        onMultipleChanged = null,
        min = null,
        max = null,
        onRangeChanged = null,
        selectedRange = null;

  const ShadCalendar.multiple({
    super.key,
    List<DateTime>? selected,
    ValueChanged<List<DateTime>>? onChanged,
    this.showOutsideDays,
    this.initialMonth,
    this.formatMonthYear,
    this.formatMonth,
    this.formatYear,
    this.formatWeekday,
    this.showWeekNumbers,
    this.weekStartsOn,
    this.fixedWeeks,
    this.hideWeekdayNames,
    this.numberOfMonths = 1,
    this.fromMonth,
    this.toMonth,
    this.onMonthChanged,
    this.reverseMonths = false,
    this.min,
    this.max,
    this.selectableDayPredicate,
    this.captionLayout,
    this.hideNavigation,
    this.yearSelectorMinWidth,
    this.monthSelectorMinWidth,
    this.yearSelectorPadding,
    this.monthSelectorPadding,
    this.navigationButtonSize,
    this.navigationButtonIconSize,
    this.backNavigationButtonIconData,
    this.forwardNavigationButtonIconData,
    this.navigationButtonPadding,
    this.navigationButtonDisabledOpacity,
    this.decoration,
    this.spacingBetweenMonths,
    this.runSpacingBetweenMonths,
    this.monthConstraints,
    this.headerHeight,
    this.headerPadding,
    this.captionLayoutGap,
    this.headerTextStyle,
    this.weekdaysPadding,
    this.weekdaysTextStyle,
    this.weekdaysTextAlign,
    this.weekNumbersHeaderText,
    this.weekNumbersHeaderTextStyle,
    this.weekNumbersTextStyle,
    this.weekNumbersTextAlign,
    this.dayButtonSize,
    this.dayButtonOutsideMonthOpacity,
    this.dayButtonPadding,
    this.dayButtonDecoration,
    this.selectedDayButtonTextStyle,
    this.insideRangeDayButtonTextStyle,
    this.dayButtonTextStyle,
    this.dayButtonVariant,
    this.selectedDayButtonVariant,
    this.insideRangeDayButtonVariant,
    this.todayButtonVariant,
    this.gridMainAxisSpacing,
    this.gridCrossAxisSpacing,
    this.dayButtonOutsideMonthTextStyle,
    this.dayButtonOutsideMonthVariant,
    this.selectedDayButtonOusideMonthVariant,
  })  : variant = ShadCalendarVariant.multiple,
        multipleSelected = selected,
        selected = null,
        onMultipleChanged = onChanged,
        onChanged = null,
        onRangeChanged = null,
        selectedRange = null,
        allowDeselection = null;

  const ShadCalendar.range({
    super.key,
    ShadDateTimeRange? selected,
    ValueChanged<ShadDateTimeRange?>? onChanged,
    this.showOutsideDays,
    this.initialMonth,
    this.formatMonthYear,
    this.formatMonth,
    this.formatYear,
    this.formatWeekday,
    this.showWeekNumbers = false,
    this.weekStartsOn,
    this.fixedWeeks,
    this.hideWeekdayNames,
    this.numberOfMonths = 1,
    this.fromMonth,
    this.toMonth,
    this.onMonthChanged,
    this.reverseMonths = false,
    this.min,
    this.max,
    this.selectableDayPredicate,
    this.captionLayout,
    this.hideNavigation,
    this.yearSelectorMinWidth,
    this.monthSelectorMinWidth,
    this.yearSelectorPadding,
    this.monthSelectorPadding,
    this.navigationButtonSize,
    this.navigationButtonIconSize,
    this.backNavigationButtonIconData,
    this.forwardNavigationButtonIconData,
    this.navigationButtonPadding,
    this.navigationButtonDisabledOpacity,
    this.decoration,
    this.spacingBetweenMonths,
    this.runSpacingBetweenMonths,
    this.monthConstraints,
    this.headerHeight,
    this.headerPadding,
    this.captionLayoutGap,
    this.headerTextStyle,
    this.weekdaysPadding,
    this.weekdaysTextStyle,
    this.weekdaysTextAlign,
    this.weekNumbersHeaderText,
    this.weekNumbersHeaderTextStyle,
    this.weekNumbersTextStyle,
    this.weekNumbersTextAlign,
    this.dayButtonSize,
    this.dayButtonOutsideMonthOpacity,
    this.dayButtonPadding,
    this.dayButtonDecoration,
    this.selectedDayButtonTextStyle,
    this.insideRangeDayButtonTextStyle,
    this.dayButtonTextStyle,
    this.dayButtonVariant,
    this.selectedDayButtonVariant,
    this.insideRangeDayButtonVariant,
    this.todayButtonVariant,
    this.gridMainAxisSpacing,
    this.gridCrossAxisSpacing,
    this.dayButtonOutsideMonthTextStyle,
    this.dayButtonOutsideMonthVariant,
    this.selectedDayButtonOusideMonthVariant,
    this.allowDeselection,
  })  : variant = ShadCalendarVariant.range,
        multipleSelected = null,
        selected = null,
        onMultipleChanged = null,
        onChanged = null,
        selectedRange = selected,
        onRangeChanged = onChanged;

  const ShadCalendar.raw({
    super.key,
    required this.variant,
    this.selected,
    this.multipleSelected,
    this.onChanged,
    this.onMultipleChanged,
    this.showOutsideDays,
    this.initialMonth,
    this.formatMonthYear,
    this.formatMonth,
    this.formatYear,
    this.formatWeekday,
    this.showWeekNumbers,
    this.weekStartsOn,
    this.fixedWeeks,
    this.hideWeekdayNames,
    this.numberOfMonths = 1,
    this.fromMonth,
    this.toMonth,
    this.onMonthChanged,
    this.reverseMonths = false,
    this.min,
    this.max,
    this.selectableDayPredicate,
    this.onRangeChanged,
    this.selectedRange,
    this.captionLayout,
    this.hideNavigation,
    this.yearSelectorMinWidth,
    this.monthSelectorMinWidth,
    this.yearSelectorPadding,
    this.monthSelectorPadding,
    this.navigationButtonSize,
    this.navigationButtonIconSize,
    this.backNavigationButtonIconData,
    this.forwardNavigationButtonIconData,
    this.navigationButtonPadding,
    this.navigationButtonDisabledOpacity,
    this.decoration,
    this.spacingBetweenMonths,
    this.runSpacingBetweenMonths,
    this.monthConstraints,
    this.headerHeight,
    this.headerPadding,
    this.captionLayoutGap,
    this.headerTextStyle,
    this.weekdaysPadding,
    this.weekdaysTextStyle,
    this.weekdaysTextAlign,
    this.weekNumbersHeaderText,
    this.weekNumbersHeaderTextStyle,
    this.weekNumbersTextStyle,
    this.weekNumbersTextAlign,
    this.dayButtonSize,
    this.dayButtonOutsideMonthOpacity,
    this.dayButtonPadding,
    this.dayButtonDecoration,
    this.selectedDayButtonTextStyle,
    this.insideRangeDayButtonTextStyle,
    this.dayButtonTextStyle,
    this.dayButtonVariant,
    this.selectedDayButtonVariant,
    this.insideRangeDayButtonVariant,
    this.todayButtonVariant,
    this.gridMainAxisSpacing,
    this.gridCrossAxisSpacing,
    this.dayButtonOutsideMonthTextStyle,
    this.dayButtonOutsideMonthVariant,
    this.selectedDayButtonOusideMonthVariant,
    this.allowDeselection,
  });

  /// {@template ShadCalendar.variant}
  /// The variant of the calendar to use.
  /// {@endtemplate}
  final ShadCalendarVariant variant;

  /// {@template ShadCalendar.selected}
  /// The date that is currently selected, defaults to null.
  /// {@endtemplate}
  final DateTime? selected;

  /// {@template ShadCalendar.multipleSelected}
  /// The dates that are currently selected, defaults to null.
  /// {@endtemplate}
  final List<DateTime>? multipleSelected;

  /// {@template ShadCalendar.onChanged}
  /// Called when the user selects a date.
  /// {@endtemplate}
  final ValueChanged<DateTime?>? onChanged;

  /// {@template ShadCalendar.onMultipleChanged}
  /// Called when the user selects multiple dates.
  /// {@endtemplate}
  final ValueChanged<List<DateTime>>? onMultipleChanged;

  /// {@template ShadCalendar.showOutsideDays}
  /// Whether to show days outside the current month, defaults to true.
  /// {@endtemplate}
  final bool? showOutsideDays;

  /// {@template ShadCalendar.initialMonth}
  /// The month to show by default, defaults to the current month.
  /// {@endtemplate}
  final DateTime? initialMonth;

  /// {@template ShadCalendar.formatMonthYear}
  /// The format to use for the month, defaults to 'LLLL y'.
  /// {@endtemplate}
  final String Function(DateTime date)? formatMonthYear;

  /// {@template ShadCalendar.formatMonth}
  /// The format to use for the month, defaults to 'LLLL'.
  /// {@endtemplate}
  final String Function(DateTime date)? formatMonth;

  /// {@template ShadCalendar.formatYear}
  /// The format to use for the year, defaults to 'y'.
  /// {@endtemplate}
  final String Function(DateTime date)? formatYear;

  /// {@template ShadCalendar.formatWeekday}
  /// The format to use for the weekday, defaults to 'EE'.
  /// {@endtemplate}
  final String Function(DateTime date)? formatWeekday;

  /// {@template ShadCalendar.showWeekNumbers}
  /// Whether to show week numbers, defaults to false.
  /// {@endtemplate}
  final bool? showWeekNumbers;

  /// {@template ShadCalendar.weekStartsOn}
  /// Which day of the week is the first day of the week.
  ///
  /// In accordance with ISO 8601 a week starts with Monday, which
  /// has the value 1, while Sunday has the value 7. Defaults to 1 (Monday).
  /// {@endtemplate}
  final int? weekStartsOn;

  /// {@template ShadCalendar.fixedWeeks}
  /// Display six weeks per months, regardless the month’s number of weeks.
  ///
  /// To use this [showOutsideDays] must be set to true.
  /// Defaults to false.
  /// {@endtemplate}
  final bool? fixedWeeks;

  /// {@template ShadCalendar.hideWeekdayNames}
  /// Hide the month’s head displaying the weekday names, defaults to false.
  /// {@endtemplate}
  final bool? hideWeekdayNames;

  /// {@template ShadCalendar.numberOfMonths}
  /// The number of displayed months, defaults to 1.
  /// {@endtemplate}
  final int numberOfMonths;

  /// {@template ShadCalendar.fromMonth}
  /// The month to start the calendar from, defaults to null.
  /// {@endtemplate}
  final DateTime? fromMonth;

  /// {@template ShadCalendar.toMonth}
  /// The month to end the calendar with, defaults to null.
  /// {@endtemplate}
  final DateTime? toMonth;

  /// {@template ShadCalendar.onMonthChanged}
  /// A callback that is called when the month changes.
  ///
  /// If the `numberOfMonths` is greater than 1, this callback will be called
  /// with the most old month displayed.
  /// {@endtemplate}
  final ValueChanged<DateTime>? onMonthChanged;

  /// {@template ShadCalendar.reverseMonths}
  /// Whether to reverse the months, defaults to false.
  /// {@endtemplate}
  final bool reverseMonths;

  /// {@template ShadCalendar.min}
  /// The minimum amount of days that can be selected.
  /// {@endtemplate}
  final int? min;

  /// {@template ShadCalendar.max}
  /// The maximum amount of days that can be selected.
  /// {@endtemplate}
  final int? max;

  /// {@template ShadCalendar.selectableDayPredicate}
  /// A function that determines whether a day is selectable.
  /// {@endtemplate}
  final SelectableDayPredicate? selectableDayPredicate;

  /// {@template ShadCalendar.selectedRange}
  /// The range of dates that are currently selected, defaults to null.
  /// {@endtemplate}
  final ShadDateTimeRange? selectedRange;

  /// {@template ShadCalendar.onRangeChanged}
  /// Called when the user selects a range of dates.
  /// {@endtemplate}
  final ValueChanged<ShadDateTimeRange?>? onRangeChanged;

  /// {@template ShadCalendar.captionLayout}
  /// The layout of the caption, defaults to [ShadCalendarCaptionLayout.label].
  /// {@endtemplate}
  final ShadCalendarCaptionLayout? captionLayout;

  /// {@template ShadCalendar.hideNavigation}
  /// Whether to hide the navigation buttons, defaults to false.
  /// {@endtemplate}
  final bool? hideNavigation;

  /// {@template ShadCalendar.yearSelectorMinWidth}
  /// The minimum width of the year selector, defaults to 100
  /// {@endtemplate}
  final double? yearSelectorMinWidth;

  /// {@template ShadCalendar.monthSelectorMinWidth}
  /// The minimum width of the month selector, defaults to 130
  /// {@endtemplate}
  final double? monthSelectorMinWidth;

  /// {@template ShadCalendar.yearSelectorPadding}
  /// The padding of the year selector, defaults to
  /// `EdgeInsets.symmetric(horizontal: 8, vertical: 4)`
  /// {@endtemplate}
  final EdgeInsets? yearSelectorPadding;

  /// {@template ShadCalendar.monthSelectorPadding}
  /// The padding of the month selector, defaults to
  /// `EdgeInsets.symmetric(horizontal: 8, vertical: 4)`
  /// {@endtemplate}
  final EdgeInsets? monthSelectorPadding;

  /// {@template ShadCalendar.navigationButtonSize}
  /// The navigation button size, defaults to 28
  /// {@endtemplate}
  final double? navigationButtonSize;

  /// {@template ShadCalendar.navigationButtonIconSize}
  /// The navigation button icon size, defaults to 16
  /// {@endtemplate}
  final double? navigationButtonIconSize;

  /// {@template ShadCalendar.backNavigationButtonIconData}
  /// The back navigation button src, defaults to [LucideIcons.chevronLeft]
  /// {@endtemplate}
  final IconData? backNavigationButtonIconData;

  /// {@template ShadCalendar.forwardNavigationButtonIconData}
  /// The forward navigation button src, defaults to [LucideIcons.chevronRight]
  /// {@endtemplate}
  final IconData? forwardNavigationButtonIconData;

  /// {@template ShadCalendar.navigationButtonPadding}
  /// The padding of the navigation button, defaults to [EdgeInsets.zero]
  /// {@endtemplate}
  final EdgeInsets? navigationButtonPadding;

  /// {@template ShadCalendar.navigationButtonDisabledOpacity}
  /// The opacity of the navigation button when disabled, defaults to .5
  /// {@endtemplate}
  final double? navigationButtonDisabledOpacity;

  /// {@template ShadCalendar.decoration}
  /// The decoration of the calendar, defaults to
  /// ```dart
  /// ShadDecoration(
  ///   border: ShadBorder.all(
  ///     radius: radius,
  ///     padding: const EdgeInsets.all(12),
  ///     color: colorScheme.border
  ///   ),
  /// )
  /// ```
  /// {@endtemplate}
  final ShadDecoration? decoration;

  /// {@template ShadCalendar.spacingBetweenMonths}
  /// The spacing between months, defaults to 16
  /// {@endtemplate}
  final double? spacingBetweenMonths;

  /// {@template ShadCalendar.runSpacingBetweenMonths}
  /// The run spacing between months, defaults to 16
  /// {@endtemplate}
  final double? runSpacingBetweenMonths;

  /// {@template ShadCalendar.monthConstraints}
  /// The month constraints, defaults to `BoxConstraints(maxWidth: 252)`
  /// or `BoxConstraints(maxWidth: 310)` depending on the [hideNavigation] and
  /// [captionLayout] values.
  /// {@endtemplate}
  final BoxConstraints? monthConstraints;

  /// {@template ShadCalendar.headerHeight}
  /// The height of the header, defaults to 38
  /// {@endtemplate}
  final double? headerHeight;

  /// {@template ShadCalendar.headerPadding}
  /// The padding of the header, defaults to `EdgeInsets.only(bottom: 16)`
  /// {@endtemplate}
  final EdgeInsets? headerPadding;

  /// {@template ShadCalendar.captionLayoutGap}
  /// The gap between the caption layout elements, defaults to 8
  /// {@endtemplate}
  final double? captionLayoutGap;

  /// {@template ShadCalendar.headerTextStyle}
  /// The text style of the header, defaults to `effectiveTextTheme.small`
  /// {@endtemplate}
  final TextStyle? headerTextStyle;

  /// {@template ShadCalendar.weekdaysPadding}
  /// The padding of the weekdays, defaults to `EdgeInsets.only(bottom: 8)`
  /// {@endtemplate}
  final EdgeInsets? weekdaysPadding;

  /// {@template ShadCalendar.weekdaysTextStyle}
  /// The text style of the weekdays, defaults to
  /// `textTheme.muted.copyWith(fontSize: 12.8)`
  /// {@endtemplate}
  final TextStyle? weekdaysTextStyle;

  /// {@template ShadCalendar.weekdaysTextAlign}
  /// The text align of the weekdays, defaults to [TextAlign.center]
  /// {@endtemplate}
  final TextAlign? weekdaysTextAlign;

  /// {@template ShadCalendar.weekNumbersHeaderText}
  /// The header text of the week numbers, defaults to `#`
  /// {@endtemplate}
  final String? weekNumbersHeaderText;

  /// {@template ShadCalendar.weekNumbersHeaderTextStyle}
  /// The header text style of the week numbers, defaults to
  /// `textTheme.muted.copyWith(fontSize: 12.8)`
  /// {@endtemplate}
  final TextStyle? weekNumbersHeaderTextStyle;

  /// {@template ShadCalendar.weekNumbersTextStyle}
  /// The text style of the week numbers, defaults to
  /// `textTheme.muted.copyWith(fontSize: 12.8)`
  /// {@endtemplate}
  final TextStyle? weekNumbersTextStyle;

  /// {@template ShadCalendar.weekNumbersTextAlign}
  /// The text align of the week numbers, defaults to [TextAlign.center]
  /// {@endtemplate}
  final TextAlign? weekNumbersTextAlign;

  /// {@template ShadCalendar.dayButtonSize}
  /// The size of the day buttons, defaults to 36
  /// {@endtemplate}
  final double? dayButtonSize;

  /// {@template ShadCalendar.dayButtonOutsideMonthOpacity}
  /// The opacity of the day buttons outside the month, defaults to .5
  /// {@endtemplate}
  final double? dayButtonOutsideMonthOpacity;

  /// {@template ShadCalendar.dayButtonPadding}
  /// The padding of the day buttons, defaults to [EdgeInsets.zero]
  /// {@endtemplate}
  final EdgeInsets? dayButtonPadding;

  /// {@template ShadCalendar.dayButtonDecoration}
  /// The decoration of the day buttons, defaults to
  /// ```dart
  /// ShadDecoration(
  ///   secondaryBorder:
  ///       const ShadBorder(padding: EdgeInsets.zero),
  ///   border: isInRange &&
  ///           !isFirstDateInRange &&
  ///           !isLastDateInRange
  ///       ? isFirstOfRow
  ///           ? ShadBorder(
  ///               radius: BorderRadius.only(
  ///                 topLeft: theme.radius.topLeft,
  ///                 bottomLeft: theme.radius.bottomLeft,
  ///               ),
  ///             )
  ///           : isLastOfRow
  ///               ? ShadBorder(
  ///                   radius: BorderRadius.only(
  ///                     topRight: theme.radius.topRight,
  ///                     bottomRight:
  ///                         theme.radius.bottomRight,
  ///                   ),
  ///                 )
  ///               : const ShadBorder(
  ///                   radius: BorderRadius.zero,
  ///                 )
  ///       : null,
  ///   ),
  /// ```
  /// {@endtemplate}
  final ShadDecoration? dayButtonDecoration;

  /// {@template ShadCalendar.selectedDayButtonTextStyle}
  /// The text style of the selected day button, defaults to
  /// ```dart
  /// textTheme.small.copyWith(
  ///   fontWeight: FontWeight.normal,
  ///   color: colorScheme.primaryForeground,
  /// )
  /// ```
  /// {@endtemplate}
  final TextStyle? selectedDayButtonTextStyle;

  /// {@template ShadCalendar.insideRangeDayButtonTextStyle}
  /// The text style of the inside range day button, defaults to
  /// ```dart
  /// textTheme.small.copyWith(
  ///   color: colorScheme.foreground,
  /// )
  /// ```
  /// {@endtemplate}
  final TextStyle? insideRangeDayButtonTextStyle;

  /// {@template ShadCalendar.dayButtonTextStyle}
  /// The text style of the day button, defaults to
  /// ```dart
  /// textTheme.small.copyWith(
  ///   fontWeight: FontWeight.normal,
  ///   color: colorScheme.foreground,
  /// )
  /// ```
  /// {@endtemplate}
  final TextStyle? dayButtonTextStyle;

  /// {@template ShadCalendar.dayButtonVariant}
  /// The variant of the day button, defaults to [ShadButtonVariant.ghost]
  /// {@endtemplate}
  final ShadButtonVariant? dayButtonVariant;

  /// {@template ShadCalendar.selectedDayButtonVariant}
  /// The variant of the selected day button, defaults to
  /// [ShadButtonVariant.primary]
  /// {@endtemplate}
  final ShadButtonVariant? selectedDayButtonVariant;

  /// {@template ShadCalendar.insideRangeDayButtonVariant}
  /// The variant of the inside range day button, defaults to
  /// [ShadButtonVariant.secondary]
  /// {@endtemplate}
  final ShadButtonVariant? insideRangeDayButtonVariant;

  /// {@template ShadCalendar.todayButtonVariant}
  /// The variant of the today button, defaults to [ShadButtonVariant.secondary]
  /// {@endtemplate}
  final ShadButtonVariant? todayButtonVariant;

  /// {@template ShadCalendar.gridMainAxisSpacing}
  /// The main axis spacing of the grid, defaults to 8
  /// {@endtemplate}
  final double? gridMainAxisSpacing;

  /// {@template ShadCalendar.gridCrossAxisSpacing}
  /// The cross axis spacing of the grid, defaults to 0
  /// {@endtemplate}
  final double? gridCrossAxisSpacing;

  /// {@template ShadCalendar.dayButtonOutsideMonthTextStyle}
  /// The text style of the day buttons outside the month, defaults to
  /// `textTheme.muted`
  /// {@endtemplate}
  final TextStyle? dayButtonOutsideMonthTextStyle;

  /// {@template ShadCalendar.dayButtonOutsideMonthVariant}
  /// The variant of the day buttons outside the month, defaults to
  /// [ShadButtonVariant.ghost]
  /// {@endtemplate}
  final ShadButtonVariant? dayButtonOutsideMonthVariant;

  /// {@template ShadCalendar.selectedDayButtonOusideMonthVariant}
  /// The variant of the selected day buttons outside the month, defaults to
  /// [ShadButtonVariant.secondary]
  /// {@endtemplate}
  final ShadButtonVariant? selectedDayButtonOusideMonthVariant;

  /// {@template ShadCalendar.allowDeselection}
  /// Whether to allow deselection of the selected date, defaults to false.
  /// {@endtemplate}
  final bool? allowDeselection;

  @override
  State<ShadCalendar> createState() => _ShadCalendarState();
}

class _ShadCalendarState extends State<ShadCalendar> {
  final today = DateTime.now().startOfDay;
  late DateTime currentMonth =
      widget.initialMonth ?? DateTime.now().startOfMonth;
  List<ShadCalendarModel> datesModels = [];
  // The first date shown in the calendar, used to render the week days
  late DateTime firstDateShown;
  bool isFirstMonthDisplayed = false;
  bool isLastMonthDisplayed = false;
  late final selectedDays = <DateTime>{
    if (widget.selected != null) widget.selected!.startOfDay,
    if (widget.multipleSelected != null)
      for (final date in widget.multipleSelected!) date.startOfDay,
  };
  late DateTime? startRange = widget.selectedRange?.start;
  late DateTime? endRange = widget.selectedRange?.end;

  final backMonthButtonHovered = ValueNotifier<bool>(false);
  final forwardMonthButtonHovered = ValueNotifier<bool>(false);

  // The list of available years in the selector
  final availableYears = <int>[];

  bool get effectiveShowOutsideDays =>
      widget.showOutsideDays ??
      ShadTheme.of(context, listen: false).calendarTheme.showOutsideDays ??
      true;

  bool get effectiveHideWeekdayNames =>
      widget.hideWeekdayNames ??
      ShadTheme.of(context, listen: false).calendarTheme.hideWeekdayNames ??
      false;

  String Function(DateTime date)? get effectiveFormatMonth =>
      widget.formatMonth ??
      ShadTheme.of(context, listen: false).calendarTheme.formatMonth ??
      defaultFormatMonth;

  String Function(DateTime date)? get effectiveFormatMonthYear =>
      widget.formatMonthYear ??
      ShadTheme.of(context, listen: false).calendarTheme.formatMonthYear ??
      defaultFormatMonthYear;

  String Function(DateTime date)? get effectiveFormatYear =>
      widget.formatYear ??
      ShadTheme.of(context, listen: false).calendarTheme.formatYear ??
      defaultFormatYear;

  String Function(DateTime date)? get effectiveFormatWeekday =>
      widget.formatWeekday ??
      ShadTheme.of(context, listen: false).calendarTheme.formatWeekday ??
      defaultFormatWeekday;

  bool get effectiveShowWeekNumbers =>
      widget.showWeekNumbers ??
      ShadTheme.of(context, listen: false).calendarTheme.showWeekNumbers ??
      false;

  int get effectiveWeekStartsOn =>
      widget.weekStartsOn ??
      ShadTheme.of(context, listen: false).calendarTheme.weekStartsOn ??
      1;

  bool get effectiveFixedWeeks =>
      widget.fixedWeeks ??
      ShadTheme.of(context, listen: false).calendarTheme.fixedWeeks ??
      false;

  bool enabled(DateTime date) {
    // disable if the predicate returns false for the date
    if (widget.selectableDayPredicate != null &&
        !widget.selectableDayPredicate!(date)) {
      return false;
    }

    // disable other days when max is reached
    if (widget.max != null && selectedDays.length >= widget.max!) {
      // only selected days are enabled
      return selectedDays.any((selectedDay) => selectedDay.isSameDay(date));
    }

    if (widget.variant == ShadCalendarVariant.range) {
      bool satifiesMin() {
        if (widget.min != null && startRange != null) {
          // only the dates after min are enabled
          final minDate = startRange!.addDays(widget.min!);
          return date.isSameDayOrGreatier(minDate) ||
              date.isSameDay(startRange!);
        }
        return true;
      }

      bool satifiesMax() {
        if (widget.max != null && startRange != null) {
          // only the dates before max are enabled
          final maxDate = startRange!.addDays(widget.max!);
          return date.isSameDayOrLower(maxDate) || date.isSameDay(startRange!);
        }
        return true;
      }

      bool isInRange() {
        return (startRange != null && date.isSameDayOrGreatier(startRange!)) &&
            (endRange != null && date.isSameDayOrLower(endRange!));
      }

      return (satifiesMin() && satifiesMax()) || isInRange();
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    generateDates();
    generateAvailableYears();
  }

  @override
  void didUpdateWidget(covariant ShadCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showOutsideDays != oldWidget.showOutsideDays ||
        widget.fixedWeeks != oldWidget.fixedWeeks ||
        widget.weekStartsOn != oldWidget.weekStartsOn ||
        widget.numberOfMonths != oldWidget.numberOfMonths ||
        widget.fromMonth != oldWidget.fromMonth ||
        widget.toMonth != oldWidget.toMonth ||
        widget.reverseMonths != oldWidget.reverseMonths ||
        widget.min != oldWidget.min ||
        widget.max != oldWidget.max ||
        widget.showWeekNumbers != oldWidget.showWeekNumbers) {
      generateDates();
    }
    if (widget.fromMonth != oldWidget.fromMonth ||
        widget.toMonth != oldWidget.toMonth) {
      generateAvailableYears();
    }

    if (widget.selected != null) {
      selectedDays
        ..clear()
        ..add(widget.selected!);
    }

    if (widget.multipleSelected != null &&
        !listEquals([...widget.multipleSelected!], selectedDays.toList())) {
      selectedDays
        ..clear()
        ..addAll(widget.multipleSelected!);
    }

    if (widget.selectedRange != null) {
      startRange = widget.selectedRange!.start;
      endRange = widget.selectedRange!.end;
    }
  }

  @override
  void dispose() {
    backMonthButtonHovered.dispose();
    forwardMonthButtonHovered.dispose();
    super.dispose();
  }

  void generateDates() {
    datesModels = [];
    var month = currentMonth.previousMonth;
    for (var i = 0; i < widget.numberOfMonths; i++) {
      final effectiveMonth = month.nextMonth;
      generateDatesForMonth(effectiveMonth);
      month = effectiveMonth;
    }

    isFirstMonthDisplayed = widget.fromMonth != null &&
        datesModels.first.month.isAtSameMomentAs(widget.fromMonth!);
    isLastMonthDisplayed = widget.toMonth != null &&
        datesModels.last.month.isAtSameMomentAs(widget.toMonth!);
  }

  void generateDatesForMonth(DateTime month) {
    var firstDate = month.startOfMonth;

    final lastDate = month.endOfMonth;
    // find the first day of the week, going back if necessary
    while (firstDate.weekday != effectiveWeekStartsOn) {
      firstDate = firstDate.previousDay;
    }
    firstDateShown = firstDate;

    final dates = <DateTime?>[];
    var coveredWholeMonth = false;
    while (!coveredWholeMonth ||
        (!effectiveFixedWeeks && dates.length % 7 != 0) ||
        (effectiveFixedWeeks && dates.length != 42)) {
      final isDayOutsideMonth = firstDate.month != month.month;
      if (isDayOutsideMonth && !effectiveShowOutsideDays) {
        dates.add(null);
      } else {
        dates.add(firstDate);
      }

      // Check if we've covered the whole month
      if (firstDate.isSameDay(lastDate) && !coveredWholeMonth) {
        coveredWholeMonth = true;
      }

      firstDate = firstDate.nextDay;
    }

    // If showWeekNumbers is enabled, duplicate the first available dates of
    // each week
    if (effectiveShowWeekNumbers) {
      for (var i = 0; i < dates.length; i += 8) {
        final sublist = dates.sublist(i);
        final firstDateOfWeek = sublist.firstWhere((d) => d != null);
        dates.insert(i, firstDateOfWeek);
      }
    }

    datesModels.add(
      ShadCalendarModel(
        month: month,
        dates: dates,
        firstDateShown: firstDateShown,
      ),
    );
  }

  void generateAvailableYears() {
    availableYears.clear();
    final minYear = widget.fromMonth?.year ?? currentMonth.year - 100;
    final maxYear = widget.toMonth?.year ?? currentMonth.year + 100;

    for (var i = minYear; i <= maxYear; i++) {
      availableYears.add(i);
    }
  }

  String defaultFormatMonthYear(DateTime date) {
    return DateFormat('LLLL y').format(date);
  }

  String defaultFormatYear(DateTime date) {
    return DateFormat('y').format(date);
  }

  String defaultFormatMonth(DateTime date) {
    return DateFormat('LLLL').format(date);
  }

  String defaultFormatWeekday(DateTime date) {
    final s = DateFormat('EE').format(date);
    if (s.length < 2) return s;
    return s.substring(0, 2);
  }

  void goToMonth(DateTime date) {
    setState(() {
      currentMonth = date;
      generateDates();
    });
    widget.onMonthChanged?.call(currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      !effectiveFixedWeeks || effectiveShowOutsideDays,
      'When fixedWeeks is true, showOutsideDays must be true',
    );

    assert(
      widget.selected == null ||
          (widget.fromMonth == null ||
              widget.selected!.isSameDayOrGreatier(widget.fromMonth!)),
      'The selected date cannot be before fromMonth',
    );

    assert(
      widget.selected == null ||
          (widget.toMonth == null ||
              widget.selected!.isSameDayOrLower(widget.toMonth!)),
      'The selected date cannot be greater than toMonth',
    );

    final theme = ShadTheme.of(context);

    final effectiveCaptionLayout =
        widget.captionLayout ?? ShadCalendarCaptionLayout.label;

    final effectiveFormatMonth = widget.formatMonth ?? defaultFormatMonth;

    final effectiveFormatYear = widget.formatYear ?? defaultFormatYear;

    final effectiveFormatMonthYear =
        widget.formatMonthYear ?? defaultFormatMonthYear;

    final effectiveFormatWeekday = widget.formatWeekday ?? defaultFormatWeekday;

    final models =
        widget.reverseMonths ? datesModels.reversed.toList() : datesModels;

    final effectiveHideNavigation =
        widget.hideNavigation ?? theme.calendarTheme.hideNavigation ?? false;

    final effectiveYearSelectorMinWidth = widget.yearSelectorMinWidth ??
        theme.calendarTheme.yearSelectorMinWidth ??
        100;

    final effectiveMonthSelectorMinWidth = widget.monthSelectorMinWidth ??
        theme.calendarTheme.monthSelectorMinWidth ??
        130;

    final effectiveYearSelectorPadding = widget.yearSelectorPadding ??
        theme.calendarTheme.yearSelectorPadding ??
        const EdgeInsets.symmetric(horizontal: 8, vertical: 4);

    final effectiveMonthSelectorPadding = widget.monthSelectorPadding ??
        theme.calendarTheme.monthSelectorPadding ??
        const EdgeInsets.symmetric(horizontal: 8, vertical: 4);

    final effectiveNavigationButtonSize = widget.navigationButtonSize ??
        theme.calendarTheme.navigationButtonSize ??
        28;

    final effectiveNavigationButtonIconSize = widget.navigationButtonIconSize ??
        theme.calendarTheme.navigationButtonIconSize ??
        16;

    final effectiveBackNavigationButtonSrc =
        widget.backNavigationButtonIconData ??
            theme.calendarTheme.backNavigationButtonIconData ??
            LucideIcons.chevronLeft;

    final effectiveForwardNavigationButtonSrc =
        widget.forwardNavigationButtonIconData ??
            theme.calendarTheme.forwardNavigationButtonIconData ??
            LucideIcons.chevronRight;

    final effectiveNavigationButtonPadding = widget.navigationButtonPadding ??
        theme.calendarTheme.navigationButtonPadding ??
        EdgeInsets.zero;

    final effectiveNavigationButtonDisabledOpacity =
        widget.navigationButtonDisabledOpacity ??
            theme.calendarTheme.navigationButtonDisabledOpacity ??
            .5;

    final effectiveDecoration =
        (theme.calendarTheme.decoration ?? const ShadDecoration())
            .mergeWith(widget.decoration);

    final effectiveSpacingBetweenMonths = widget.spacingBetweenMonths ??
        theme.calendarTheme.spacingBetweenMonths ??
        16;

    final effectiveRunSpacingBetweenMonths = widget.runSpacingBetweenMonths ??
        theme.calendarTheme.runSpacingBetweenMonths ??
        16;

    final effectiveMonthConstraints = widget.monthConstraints ??
        theme.calendarTheme.monthConstraints ??
        BoxConstraints(
          maxWidth: 252 +
              (!effectiveHideNavigation &&
                      effectiveCaptionLayout != ShadCalendarCaptionLayout.label
                  ? 58
                  : 0),
        );

    final effectiveHeaderHeight =
        widget.headerHeight ?? theme.calendarTheme.headerHeight ?? 38;

    final effectiveHeaderPadding = widget.headerPadding ??
        theme.calendarTheme.headerPadding ??
        const EdgeInsets.only(bottom: 16);

    final effectiveCaptionLayoutGap =
        widget.captionLayoutGap ?? theme.calendarTheme.captionLayoutGap ?? 8;

    final effectiveHeaderTextStyle = widget.headerTextStyle ??
        theme.calendarTheme.headerTextStyle ??
        theme.textTheme.small;

    final effectiveWeekdaysPadding = widget.weekdaysPadding ??
        theme.calendarTheme.weekdaysPadding ??
        const EdgeInsets.only(bottom: 8);

    final effectiveWeekdaysTextStyle = widget.weekdaysTextStyle ??
        theme.calendarTheme.weekdaysTextStyle ??
        theme.textTheme.muted.copyWith(fontSize: 12.8);

    final effectiveWeekdaysTextAlign = widget.weekdaysTextAlign ??
        theme.calendarTheme.weekdaysTextAlign ??
        TextAlign.center;

    final effectiveWeekNumbersHeaderText = widget.weekNumbersHeaderText ??
        theme.calendarTheme.weekNumbersHeaderText ??
        '#';

    final effectiveWeekNumbersHeaderTextStyle =
        widget.weekNumbersHeaderTextStyle ??
            theme.calendarTheme.weekNumbersHeaderTextStyle ??
            theme.textTheme.muted.copyWith(fontSize: 12.8);

    final effectiveGridMainAxisSpacing = widget.gridMainAxisSpacing ??
        theme.calendarTheme.gridMainAxisSpacing ??
        8;

    final effectiveGridCrossAxisSpacing = widget.gridCrossAxisSpacing ??
        theme.calendarTheme.gridCrossAxisSpacing ??
        0;

    final effectiveInsideRangeDayButtonTextStyle =
        widget.insideRangeDayButtonTextStyle ??
            theme.calendarTheme.insideRangeDayButtonTextStyle ??
            theme.textTheme.small.copyWith(
              color: theme.colorScheme.foreground,
            );

    final effectiveSelectedDayButtonTextStyle =
        widget.selectedDayButtonTextStyle ??
            theme.calendarTheme.selectedDayButtonTextStyle ??
            theme.textTheme.small.copyWith(
              fontWeight: FontWeight.normal,
              color: theme.colorScheme.primaryForeground,
            );

    final effectiveDayButtonTextStyle = widget.dayButtonTextStyle ??
        theme.calendarTheme.dayButtonTextStyle ??
        theme.textTheme.small.copyWith(
          fontWeight: FontWeight.normal,
          color: theme.colorScheme.foreground,
        );

    final effectiveDayButtonOutsideMonthTextStyle =
        widget.dayButtonOutsideMonthTextStyle ??
            theme.calendarTheme.dayButtonOutsideMonthTextStyle ??
            theme.textTheme.muted;

    final effectiveWeekNumbersTextStyle = widget.weekNumbersTextStyle ??
        theme.calendarTheme.weekNumbersTextStyle ??
        theme.textTheme.muted.copyWith(fontSize: 12.8);

    final effectiveDayButtonSize =
        widget.dayButtonSize ?? theme.calendarTheme.dayButtonSize ?? 36;

    final effectiveDayButtonOutsideMonthOpacity =
        widget.dayButtonOutsideMonthOpacity ??
            theme.calendarTheme.dayButtonOutsideMonthOpacity ??
            .5;

    final effectiveDayButtonPadding = widget.dayButtonPadding ??
        theme.calendarTheme.dayButtonPadding ??
        EdgeInsets.zero;

    final effectiveDayButtonVariant = widget.dayButtonVariant ??
        theme.calendarTheme.dayButtonVariant ??
        ShadButtonVariant.ghost;

    final effectiveSelectedDayButtonVariant = widget.selectedDayButtonVariant ??
        theme.calendarTheme.selectedDayButtonVariant ??
        ShadButtonVariant.primary;

    final effectiveInsideRangeDayButtonVariant =
        widget.insideRangeDayButtonVariant ??
            theme.calendarTheme.insideRangeDayButtonVariant ??
            ShadButtonVariant.secondary;

    final effectiveDayButtonOutsideMonthVariant =
        widget.dayButtonOutsideMonthVariant ??
            theme.calendarTheme.dayButtonOutsideMonthVariant ??
            ShadButtonVariant.ghost;

    final effectiveSelectedDayButtonOusideMonthVariant =
        widget.selectedDayButtonOusideMonthVariant ??
            theme.calendarTheme.selectedDayButtonOusideMonthVariant ??
            ShadButtonVariant.secondary;

    final effectiveTodayButtonVariant = widget.todayButtonVariant ??
        theme.calendarTheme.todayButtonVariant ??
        ShadButtonVariant.secondary;

    final effectiveAllowDeselection = widget.allowDeselection ??
        theme.calendarTheme.allowDeselection ??
        false;

    final yearSelector = ShadSelect<int>(
      initialValue: currentMonth.year,
      padding: effectiveYearSelectorPadding,
      minWidth: effectiveYearSelectorMinWidth,
      selectedOptionBuilder: (context, value) {
        return Text(effectiveFormatYear(DateTime(value, currentMonth.month)));
      },
      options: availableYears.map(
        (year) => ShadOption(
          value: year,
          child: Text(effectiveFormatYear(DateTime(year))),
        ),
      ),
      onChanged: (year) {
        if (year != null) {
          goToMonth(DateTime(year, currentMonth.month));
        }
      },
    );

    final monthSelector = ShadSelect<int>(
      initialValue: currentMonth.month,
      padding: effectiveMonthSelectorPadding,
      minWidth: effectiveMonthSelectorMinWidth,
      selectedOptionBuilder: (context, value) {
        return Text(effectiveFormatMonth(DateTime(currentMonth.year, value)));
      },
      options: List.generate(
        12,
        (index) {
          final d = DateTime(currentMonth.year, index + 1);
          return ShadOption(
            value: index + 1,
            child: Text(effectiveFormatMonth(d)),
          );
        },
      ),
      onChanged: (month) {
        if (month != null) {
          goToMonth(DateTime(currentMonth.year, month));
        }
      },
    );

    final backButton = ValueListenableBuilder<bool>(
      valueListenable: backMonthButtonHovered,
      builder: (context, isHovered, _) {
        return Opacity(
          opacity: isHovered ? 1 : effectiveNavigationButtonDisabledOpacity,
          child: ShadButton.outline(
            width: effectiveNavigationButtonSize,
            height: effectiveNavigationButtonSize,
            padding: effectiveNavigationButtonPadding,
            enabled: !isFirstMonthDisplayed,
            onHoverChange: (hovered) => backMonthButtonHovered.value = hovered,
            icon: Icon(
              effectiveBackNavigationButtonSrc,
              size: effectiveNavigationButtonIconSize,
            ),
            onPressed: () => goToMonth(currentMonth.previousMonth),
          ),
        );
      },
    );

    final forwardButton = ValueListenableBuilder<bool>(
      valueListenable: forwardMonthButtonHovered,
      builder: (context, isHovered, _) {
        return Opacity(
          opacity: isHovered ? 1 : effectiveNavigationButtonDisabledOpacity,
          child: ShadButton.outline(
            width: effectiveNavigationButtonSize,
            height: effectiveNavigationButtonSize,
            padding: effectiveNavigationButtonPadding,
            enabled: !isLastMonthDisplayed,
            onHoverChange: (hovered) =>
                forwardMonthButtonHovered.value = hovered,
            onPressed: () => goToMonth(currentMonth.nextMonth),
            child: Icon(
              effectiveForwardNavigationButtonSrc,
              size: effectiveNavigationButtonIconSize,
            ),
          ),
        );
      },
    );

    final columnsCount = effectiveShowWeekNumbers ? 8 : 7;

    return ShadDecorator(
      decoration: effectiveDecoration,
      child: Wrap(
        spacing: effectiveSpacingBetweenMonths,
        runSpacing: effectiveRunSpacingBetweenMonths,
        children: models.mapIndexed((index, dateModel) {
          final isFirstMonth = index == 0;
          final isLastMonth = index == models.length - 1;

          final labelNavigation = Stack(
            children: [
              if (isFirstMonth && !effectiveHideNavigation) backButton,
              Center(
                child: Text(
                  effectiveFormatMonthYear(dateModel.month),
                  style: effectiveHeaderTextStyle,
                ),
              ),
              if (isLastMonth && !effectiveHideNavigation)
                Align(alignment: Alignment.topRight, child: forwardButton),
            ],
          );

          return ConstrainedBox(
            constraints: effectiveMonthConstraints,
            child: Column(
              children: [
                // month header and back/forward buttons
                Padding(
                  padding: effectiveHeaderPadding,
                  child: SizedBox(
                    height: effectiveHeaderHeight,
                    child: !isFirstMonth &&
                            effectiveCaptionLayout !=
                                ShadCalendarCaptionLayout.label
                        ? Center(
                            child: Text(
                              effectiveFormatMonthYear(dateModel.month),
                              style: effectiveHeaderTextStyle,
                            ),
                          )
                        : switch (effectiveCaptionLayout) {
                            ShadCalendarCaptionLayout.label => labelNavigation,
                            ShadCalendarCaptionLayout.dropdown => Row(
                                children: [
                                  monthSelector,
                                  yearSelector,
                                  if (!effectiveHideNavigation) ...[
                                    backButton,
                                    forwardButton,
                                  ],
                                ],
                              ),
                            ShadCalendarCaptionLayout.dropdownMonths => Row(
                                children: [
                                  monthSelector,
                                  SizedBox(width: effectiveCaptionLayoutGap),
                                  Expanded(
                                    child: Text(
                                      effectiveFormatYear(dateModel.month),
                                      style: effectiveHeaderTextStyle,
                                    ),
                                  ),
                                  if (!effectiveHideNavigation) ...[
                                    backButton,
                                    forwardButton,
                                  ],
                                ],
                              ),
                            ShadCalendarCaptionLayout.dropdownYears => Row(
                                children: [
                                  yearSelector,
                                  SizedBox(width: effectiveCaptionLayoutGap),
                                  Expanded(
                                    child: Text(
                                      effectiveFormatMonth(dateModel.month),
                                      style: effectiveHeaderTextStyle,
                                    ),
                                  ),
                                  if (!effectiveHideNavigation) ...[
                                    backButton,
                                    forwardButton,
                                  ],
                                ],
                              ),
                          },
                  ),
                ),
                // week days
                Offstage(
                  offstage: effectiveHideWeekdayNames,
                  child: Padding(
                    padding: effectiveWeekdaysPadding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        columnsCount,
                        (index) {
                          if (effectiveShowWeekNumbers && index == 0) {
                            return Expanded(
                              child: Text(
                                effectiveWeekNumbersHeaderText,
                                style: effectiveWeekNumbersHeaderTextStyle,
                                textAlign: effectiveWeekdaysTextAlign,
                              ),
                            );
                          }
                          final date = dateModel.firstDateShown.addDays(
                            index - (effectiveShowWeekNumbers ? 1 : 0),
                          );
                          return Expanded(
                            child: Text(
                              effectiveFormatWeekday(date),
                              style: effectiveWeekdaysTextStyle,
                              textAlign: effectiveWeekdaysTextAlign,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  mainAxisSpacing: effectiveGridMainAxisSpacing,
                  crossAxisSpacing: effectiveGridCrossAxisSpacing,
                  crossAxisCount: columnsCount,
                  shrinkWrap: true,
                  children: dateModel.dates.mapIndexed((index, date) {
                    if (date == null) return const SizedBox.shrink();
                    final selected = switch (widget.variant) {
                      ShadCalendarVariant.range => false,
                      ShadCalendarVariant.single ||
                      ShadCalendarVariant.multiple =>
                        selectedDays.any(
                          (selectedDate) => selectedDate.isSameDay(date),
                        ),
                    };

                    final isInRange = switch (widget.variant) {
                      ShadCalendarVariant.range => (startRange != null &&
                              date.isSameDayOrGreatier(startRange!)) &&
                          (endRange != null &&
                              date.isSameDayOrLower(endRange!)),
                      ShadCalendarVariant.single ||
                      ShadCalendarVariant.multiple =>
                        false,
                    };

                    final isFirstDateInRange =
                        startRange != null && date.isSameDay(startRange!);
                    final isLastDateInRange =
                        endRange != null && date.isSameDay(endRange!);

                    final isToday = date.isSameDay(today);
                    final isInMonth = date.month == dateModel.month.month;
                    final textStyle = switch (widget.variant) {
                      ShadCalendarVariant.range => () {
                          if (isFirstDateInRange || isLastDateInRange) {
                            return effectiveSelectedDayButtonTextStyle;
                          }

                          if (isInRange) {
                            return effectiveInsideRangeDayButtonTextStyle;
                          }

                          return effectiveDayButtonTextStyle;
                        }(),
                      ShadCalendarVariant.single ||
                      ShadCalendarVariant.multiple =>
                        isInMonth
                            ? selected
                                ? effectiveSelectedDayButtonTextStyle
                                : effectiveDayButtonTextStyle
                            : effectiveDayButtonOutsideMonthTextStyle
                    };

                    final variant = switch (widget.variant) {
                      ShadCalendarVariant.range => () {
                          if (isFirstDateInRange || isLastDateInRange) {
                            return effectiveSelectedDayButtonVariant;
                          }
                          if (isInRange) {
                            return effectiveInsideRangeDayButtonVariant;
                          }
                          if (isToday) return effectiveTodayButtonVariant;
                          return effectiveDayButtonVariant;
                        }(),
                      ShadCalendarVariant.single ||
                      ShadCalendarVariant.multiple =>
                        switch (isInMonth) {
                          true => selected
                              ? effectiveSelectedDayButtonVariant
                              : isToday
                                  ? effectiveTodayButtonVariant
                                  : effectiveDayButtonVariant,
                          false => selected
                              ? effectiveSelectedDayButtonOusideMonthVariant
                              : effectiveDayButtonOutsideMonthVariant,
                        },
                    };

                    if (effectiveShowWeekNumbers && index % 8 == 0) {
                      return Center(
                        child: Text(
                          date.weekNumber.toString(),
                          style: effectiveWeekNumbersTextStyle,
                        ),
                      );
                    }

                    final isFirstOfRow =
                        (index - (effectiveShowWeekNumbers ? 1 : 0)) % 7 == 0;
                    final isLastOfRow =
                        (index - (effectiveShowWeekNumbers ? 1 : 0)) % 7 == 6;

                    final effectiveDayButtonDecoration = ShadDecoration(
                      secondaryBorder:
                          const ShadBorder(padding: EdgeInsets.zero),
                      border: isInRange &&
                              !isFirstDateInRange &&
                              !isLastDateInRange
                          ? isFirstOfRow
                              ? ShadBorder(
                                  radius: BorderRadius.only(
                                    topLeft: theme.radius.topLeft,
                                    bottomLeft: theme.radius.bottomLeft,
                                  ),
                                )
                              : isLastOfRow
                                  ? ShadBorder(
                                      radius: BorderRadius.only(
                                        topRight: theme.radius.topRight,
                                        bottomRight: theme.radius.bottomRight,
                                      ),
                                    )
                                  : const ShadBorder(
                                      radius: BorderRadius.zero,
                                    )
                          : null,
                    )
                        .mergeWith(theme.calendarTheme.dayButtonDecoration)
                        .mergeWith(widget.dayButtonDecoration);

                    return Center(
                      child: Opacity(
                        opacity: isInMonth
                            ? 1
                            : effectiveDayButtonOutsideMonthOpacity,
                        child: ShadButton.raw(
                          variant: variant,
                          width: effectiveDayButtonSize,
                          height: effectiveDayButtonSize,
                          decoration: effectiveDayButtonDecoration,
                          enabled: enabled(date),
                          padding: effectiveDayButtonPadding,
                          child: Text(
                            date.day.toString(),
                            style: textStyle,
                          ),
                          onPressed: () {
                            // ignore the operation if the min is reached
                            if (selectedDays.contains(date) &&
                                widget.min != null &&
                                selectedDays.length == widget.min) {
                              return;
                            }

                            if (widget.variant == ShadCalendarVariant.single) {
                              final selectedDate = selectedDays.firstOrNull;
                              selectedDays.clear();
                              if (effectiveAllowDeselection &&
                                  (selectedDate?.isSameDay(date) ?? false)) {
                                widget.onChanged?.call(null);

                                return;
                              }
                            }
                            final startRangeEquals =
                                startRange?.isSameDay(date) ?? false;
                            final endDateEquals =
                                endRange?.isSameDay(date) ?? false;

                            final singleDateSelectedInRange =
                                (startRangeEquals && endRange == null) ||
                                    (endDateEquals && startRange == null);

                            // Skip the operation on the range if a single date
                            // is selected and allowDeselection is false
                            if (widget.variant == ShadCalendarVariant.range) {
                              if (singleDateSelectedInRange &&
                                  !effectiveAllowDeselection) {
                                return;
                              }
                            }

                            setState(() {
                              if (widget.variant == ShadCalendarVariant.range) {
                                // deselect the range
                                if (singleDateSelectedInRange) {
                                  startRange = null;
                                } else {
                                  // select the start range
                                  if (startRange == null) {
                                    startRange = date;
                                  } else {
                                    // update the start range
                                    if (isFirstDateInRange ||
                                        isLastDateInRange) {
                                      startRange = date;
                                      endRange = null;
                                    } else {
                                      // update the start/end range based on the date position
                                      if (date.isBefore(startRange!)) {
                                        startRange = date;
                                      } else {
                                        endRange = date;
                                      }
                                    }
                                  }
                                }
                              } else {
                                if (selectedDays.contains(date)) {
                                  selectedDays.remove(date);
                                } else {
                                  selectedDays.add(date);
                                }
                              }
                            });

                            switch (widget.variant) {
                              case ShadCalendarVariant.single:
                                widget.onChanged?.call(date);
                              case ShadCalendarVariant.multiple:
                                widget.onMultipleChanged
                                    ?.call(selectedDays.toList());
                              case ShadCalendarVariant.range:
                                widget.onRangeChanged?.call(
                                  ShadDateTimeRange(
                                    start: startRange,
                                    end: endRange,
                                  ),
                                );
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
