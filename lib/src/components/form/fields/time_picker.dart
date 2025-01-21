import 'package:flutter/material.dart';
import 'package:shadcn_ui/src/components/form/field.dart';
import 'package:shadcn_ui/src/components/time_picker.dart';
import 'package:shadcn_ui/src/theme/components/decorator.dart';

class ShadTimePickerFormField extends ShadFormBuilderField<ShadTimeOfDay> {
  ShadTimePickerFormField({
    super.id,
    super.key,
    super.onSaved,
    super.label,
    super.error,
    super.description,
    super.valueTransformer,
    super.onReset,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    super.validator,
    super.focusNode,

    /// {@macro ShadTimePicker.onChanged}
    super.onChanged,

    /// {@macro ShadTimePicker.initialValue}
    super.initialValue,

    /// @macro ShadTimePicker.controller
    this.controller,

    /// {@macro ShadTimePicker.axis}
    Axis? axis,

    /// {@macro ShadTimePicker.spacing}
    double? spacing,

    /// {@macro ShadTimePicker.runSpacing}
    double? runSpacing,

    /// {@macro ShadTimePicker.jumpToNextFieldWhenFilled}
    bool? jumpToNextFieldWhenFilled,

    /// {@macro ShadTimePicker.hourLabel}
    Widget? hourLabel,

    /// {@macro ShadTimePicker.minuteLabel}
    Widget? minuteLabel,

    /// {@macro ShadTimePicker.secondLabel}
    Widget? secondLabel,

    /// {@macro ShadTimePicker.hourHintText}
    String? hourHintText,

    /// {@macro ShadTimePicker.minuteHintText}
    String? minuteHintText,

    /// {@macro ShadTimePicker.secondHintText}
    String? secondHintText,

    /// {@macro ShadTimePicker.leading}
    Widget? leading,

    /// {@macro ShadTimePicker.trailing}
    Widget? trailing,

    /// {@macro ShadTimePicker.alignment}
    WrapAlignment? alignment,

    /// {@macro ShadTimePicker.runAlignment}
    WrapAlignment? runAlignment,

    /// {@macro ShadTimePicker.crossAxisAlignment}
    WrapCrossAlignment? crossAxisAlignment,

    /// {@macro ShadTimePicker.maxHour}
    int maxHour = 23,

    /// {@macro ShadTimePicker.maxMinute}
    int maxMinute = 59,

    /// {@macro ShadTimePicker.maxSecond}
    int maxSecond = 59,

    /// {@macro ShadTimePicker.minHour}
    int minHour = 0,

    /// {@macro ShadTimePicker.minMinute}
    int minMinute = 0,

    /// {@macro ShadTimePicker.minSecond}
    int minSecond = 0,

    /// {@macro ShadTimePicker.gap}
    double? gap,

    /// {@macro ShadTimePicker.style}
    TextStyle? style,

    /// {@macro ShadTimePicker.placeholderStyle}
    TextStyle? placeholderStyle,

    /// {@macro ShadTimePicker.labelStyle}
    TextStyle? labelStyle,

    /// {@macro ShadTimePicker.fieldWidth}
    double? fieldWidth,

    /// {@macro ShadTimePicker.fieldPadding}
    EdgeInsets? fieldPadding,

    /// {@macro ShadTimePicker.fieldDecoration}
    ShadDecoration? fieldDecoration,
  }) : super(
          builder: (field) {
            final state = field as _ShadFormBuilderTimePickerState;
            return ShadTimePicker(
              controller: state.controller,
              onChanged: state.didChange,
              enabled: state.enabled,
              initialValue: state.initialValue,
              axis: axis,
              spacing: spacing,
              runSpacing: runSpacing,
              jumpToNextFieldWhenFilled: jumpToNextFieldWhenFilled,
              hourLabel: hourLabel,
              minuteLabel: minuteLabel,
              secondLabel: secondLabel,
              hourHintText: hourHintText,
              minuteHintText: minuteHintText,
              secondHintText: secondHintText,
              leading: leading,
              trailing: trailing,
              alignment: alignment,
              runAlignment: runAlignment,
              crossAxisAlignment: crossAxisAlignment,
              maxHour: maxHour,
              maxMinute: maxMinute,
              maxSecond: maxSecond,
              minHour: minHour,
              minMinute: minMinute,
              minSecond: minSecond,
              gap: gap,
              style: style,
              placeholderStyle: placeholderStyle,
              labelStyle: labelStyle,
              fieldWidth: fieldWidth,
              fieldPadding: fieldPadding,
              fieldDecoration: fieldDecoration,
            );
          },
        );

  ShadTimePickerFormField.period({
    super.id,
    super.key,
    super.onSaved,
    super.label,
    super.error,
    super.description,
    super.valueTransformer,
    super.onReset,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    super.validator,

    /// {@macro ShadTimePicker.onChanged}
    super.onChanged,

    /// {@macro ShadTimePicker.initialValue}
    super.initialValue,

    /// @macro ShadTimePicker.controller
    this.controller,

    /// {@macro ShadTimePicker.axis}
    Axis? axis,

    /// {@macro ShadTimePicker.spacing}
    double? spacing,

    /// {@macro ShadTimePicker.runSpacing}
    double? runSpacing,

    /// {@macro ShadTimePicker.jumpToNextFieldWhenFilled}
    bool? jumpToNextFieldWhenFilled,

    /// {@macro ShadTimePicker.hourLabel}
    Widget? hourLabel,

    /// {@macro ShadTimePicker.minuteLabel}
    Widget? minuteLabel,

    /// {@macro ShadTimePicker.secondLabel}
    Widget? secondLabel,

    /// {@macro ShadTimePicker.hourHintText}
    String? hourHintText,

    /// {@macro ShadTimePicker.minuteHourText}
    String? minuteHourText,

    /// {@macro ShadTimePicker.secondHintText}
    String? secondHintText,

    /// {@macro ShadTimePicker.leading}
    Widget? leading,

    /// {@macro ShadTimePicker.trailing}
    Widget? trailing,

    /// {@macro ShadTimePicker.alignment}
    WrapAlignment? alignment,

    /// {@macro ShadTimePicker.runAlignment}
    WrapAlignment? runAlignment,

    /// {@macro ShadTimePicker.crossAxisAlignment}
    WrapCrossAlignment? crossAxisAlignment,

    /// {@macro ShadTimePicker.maxHour}
    int maxHour = 23,

    /// {@macro ShadTimePicker.maxMinute}
    int maxMinute = 59,

    /// {@macro ShadTimePicker.maxSecond}
    int maxSecond = 59,

    /// {@macro ShadTimePicker.minHour}
    int minHour = 0,

    /// {@macro ShadTimePicker.minMinute}
    int minMinute = 0,

    /// {@macro ShadTimePicker.minSecond}
    int minSecond = 0,

    /// {@macro ShadTimePicker.initialDayPeriod}
    DayPeriod? initialDayPeriod,

    /// {@macro ShadTimePicker.periodLabel}
    Widget? periodLabel,

    /// {@macro ShadTimePicker.periodPlaceholder}
    Widget? periodPlaceholder,

    /// {@macro ShadTimePicker.periodHeight}
    double? periodHeight,

    /// {@macro ShadTimePicker.periodMinWidth}
    double? periodMinWidth,

    /// {@macro ShadTimePicker.gap}
    double? gap,

    /// {@macro ShadTimePicker.style}
    TextStyle? style,

    /// {@macro ShadTimePicker.placeholderStyle}
    TextStyle? placeholderStyle,

    /// {@macro ShadTimePicker.labelStyle}
    TextStyle? labelStyle,

    /// {@macro ShadTimePicker.fieldWidth}
    double? fieldWidth,

    /// {@macro ShadTimePicker.fieldPadding}
    EdgeInsets? fieldPadding,

    /// {@macro ShadTimePicker.fieldDecoration}
    ShadDecoration? fieldDecoration,

    /// {@macro ShadTimePicker.periodDecoration}
    ShadDecoration? periodDecoration,
  }) : super(
          builder: (field) {
            final state = field as _ShadFormBuilderTimePickerState;
            return ShadTimePicker.period(
              controller: state.controller,
              onChanged: state.didChange,
              enabled: state.enabled,
              initialValue: state.initialValue,
              axis: axis,
              spacing: spacing,
              runSpacing: runSpacing,
              jumpToNextFieldWhenFilled: jumpToNextFieldWhenFilled,
              hourLabel: hourLabel,
              minuteLabel: minuteLabel,
              secondLabel: secondLabel,
              hourHintText: hourHintText,
              minuteHintText: minuteHourText,
              secondHintText: secondHintText,
              leading: leading,
              trailing: trailing,
              alignment: alignment,
              runAlignment: runAlignment,
              crossAxisAlignment: crossAxisAlignment,
              maxHour: maxHour,
              maxMinute: maxMinute,
              maxSecond: maxSecond,
              minHour: minHour,
              minMinute: minMinute,
              minSecond: minSecond,
              initialDayPeriod: initialDayPeriod,
              periodLabel: periodLabel,
              periodPlaceholder: periodPlaceholder,
              periodHeight: periodHeight,
              periodMinWidth: periodMinWidth,
              gap: gap,
              style: style,
              placeholderStyle: placeholderStyle,
              labelStyle: labelStyle,
              fieldWidth: fieldWidth,
              fieldPadding: fieldPadding,
              fieldDecoration: fieldDecoration,
              periodDecoration: periodDecoration,
            );
          },
        );

  ShadTimePickerFormField.raw({
    required ShadTimePickerVariant variant,
    super.id,
    super.key,
    super.onSaved,
    super.label,
    super.error,
    super.description,
    super.valueTransformer,
    super.onReset,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    super.validator,

    /// {@macro ShadTimePicker.onChanged}
    super.onChanged,

    /// {@macro ShadTimePicker.initialValue}
    super.initialValue,

    /// @macro ShadTimePicker.controller
    this.controller,

    /// {@macro ShadTimePicker.axis}
    Axis? axis,

    /// {@macro ShadTimePicker.spacing}
    double? spacing,

    /// {@macro ShadTimePicker.runSpacing}
    double? runSpacing,

    /// {@macro ShadTimePicker.jumpToNextFieldWhenFilled}
    bool? jumpToNextFieldWhenFilled,

    /// {@macro ShadTimePicker.hourLabel}
    Widget? hourLabel,

    /// {@macro ShadTimePicker.minuteLabel}
    Widget? minuteLabel,

    /// {@macro ShadTimePicker.secondLabel}
    Widget? secondLabel,

    /// {@macro ShadTimePicker.hourHintText}
    String? hourHintText,

    /// {@macro ShadTimePicker.minuteHintText}
    String? minuteHintText,

    /// {@macro ShadTimePicker.secondHintText}
    String? secondHintText,

    /// {@macro ShadTimePicker.leading}
    Widget? leading,

    /// {@macro ShadTimePicker.trailing}
    Widget? trailing,

    /// {@macro ShadTimePicker.alignment}
    WrapAlignment? alignment,

    /// {@macro ShadTimePicker.runAlignment}
    WrapAlignment? runAlignment,

    /// {@macro ShadTimePicker.crossAxisAlignment}
    WrapCrossAlignment? crossAxisAlignment,

    /// {@macro ShadTimePicker.maxHour}
    int maxHour = 23,

    /// {@macro ShadTimePicker.maxMinute}
    int maxMinute = 59,

    /// {@macro ShadTimePicker.maxSecond}
    int maxSecond = 59,

    /// {@macro ShadTimePicker.minHour}
    int minHour = 0,

    /// {@macro ShadTimePicker.minMinute}
    int minMinute = 0,

    /// {@macro ShadTimePicker.minSecond}
    int minSecond = 0,

    /// {@macro ShadTimePicker.initialDayPeriod}
    DayPeriod? initialDayPeriod,

    /// {@macro ShadTimePicker.periodLabel}
    Widget? periodLabel,

    /// {@macro ShadTimePicker.periodPlaceholder}
    Widget? periodPlaceholder,

    /// {@macro ShadTimePicker.periodHeight}
    double? periodHeight,

    /// {@macro ShadTimePicker.periodMinWidth}
    double? periodMinWidth,

    /// {@macro ShadTimePicker.gap}
    double? gap,

    /// {@macro ShadTimePicker.style}
    TextStyle? style,

    /// {@macro ShadTimePicker.placeholderStyle}
    TextStyle? placeholderStyle,

    /// {@macro ShadTimePicker.labelStyle}
    TextStyle? labelStyle,

    /// {@macro ShadTimePicker.fieldWidth}
    double? fieldWidth,

    /// {@macro ShadTimePicker.fieldPadding}
    EdgeInsets? fieldPadding,

    /// {@macro ShadTimePicker.fieldDecoration}
    ShadDecoration? fieldDecoration,

    /// {@macro ShadTimePicker.periodDecoration}
    ShadDecoration? periodDecoration,
  }) : super(
          builder: (field) {
            final state = field as _ShadFormBuilderTimePickerState;
            return ShadTimePicker.raw(
              variant: variant,
              controller: state.controller,
              onChanged: state.didChange,
              enabled: state.enabled,
              initialValue: state.initialValue,
              axis: axis,
              spacing: spacing,
              runSpacing: runSpacing,
              jumpToNextFieldWhenFilled: jumpToNextFieldWhenFilled,
              hourLabel: hourLabel,
              minuteLabel: minuteLabel,
              secondLabel: secondLabel,
              hourHintText: hourHintText,
              minuteHintText: minuteHintText,
              secondHintText: secondHintText,
              leading: leading,
              trailing: trailing,
              alignment: alignment,
              runAlignment: runAlignment,
              crossAxisAlignment: crossAxisAlignment,
              maxHour: maxHour,
              maxMinute: maxMinute,
              maxSecond: maxSecond,
              minHour: minHour,
              minMinute: minMinute,
              minSecond: minSecond,
              initialDayPeriod: initialDayPeriod,
              periodLabel: periodLabel,
              periodPlaceholder: periodPlaceholder,
              periodHeight: periodHeight,
              periodMinWidth: periodMinWidth,
              gap: gap,
              style: style,
              placeholderStyle: placeholderStyle,
              labelStyle: labelStyle,
              fieldWidth: fieldWidth,
              fieldPadding: fieldPadding,
              fieldDecoration: fieldDecoration,
              periodDecoration: periodDecoration,
            );
          },
        );

  @override
  ShadFormBuilderFieldState<ShadTimePickerFormField, ShadTimeOfDay>
      createState() => _ShadFormBuilderTimePickerState();

  final ShadTimePickerController? controller;
}

class _ShadFormBuilderTimePickerState
    extends ShadFormBuilderFieldState<ShadTimePickerFormField, ShadTimeOfDay> {
  // ignore: use_late_for_private_fields_and_variables
  ShadTimePickerController? _controller;
  ShadTimePickerController get controller => widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ShadTimePickerController.fromTimeOfDay(widget.initialValue);
    }
  }
}
