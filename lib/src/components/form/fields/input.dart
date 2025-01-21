import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/src/components/form/field.dart';
import 'package:shadcn_ui/src/components/input.dart';
import 'package:shadcn_ui/src/theme/components/decorator.dart';
import 'package:shadcn_ui/src/theme/theme.dart';

class ShadInputFormField extends ShadFormBuilderField<String> {
  ShadInputFormField({
    super.id,
    super.key,
    super.onSaved,
    String? Function(String)? validator,
    String? initialValue,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    this.controller,
    super.label,
    super.error,
    super.description,
    void Function(String)? onChanged,
    super.valueTransformer,
    super.onReset,
    ShadDecoration? decoration,
    String? hintText,
    TextMagnifierConfiguration magnifierConfiguration =
        TextMagnifierConfiguration.disabled,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool autofocus = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    super.readOnly,
    bool? showCursor,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    AppPrivateCommandCallback? onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    GestureTapCallback? onPressed,
    bool onPressedAlwaysCalled = false,
    TapRegionCallback? onPressedOutside,
    MouseCursor? mouseCursor,
    ScrollPhysics? scrollPhysics,
    ScrollController? scrollController,
    Iterable<String>? autofillHints,
    Clip clipBehavior = Clip.hardEdge,
    bool scribbleEnabled = true,
    bool enableIMEPersonalizedLearning = true,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    UndoHistoryController? undoController,
    SpellCheckConfiguration? spellCheckConfiguration,
    Color? selectionColor,
    EdgeInsets? padding,
    Widget? prefix,
    Widget? suffix,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    TextStyle? placeholderStyle,
    EdgeInsets? inputPadding,
    double? gap,
  }) : super(
          initialValue: controller != null ? controller.text : initialValue,
          validator: validator == null ? null : (v) => validator(v ?? ''),
          onChanged: onChanged == null ? null : (v) => onChanged(v ?? ''),
          decorationBuilder: (context) =>
              (ShadTheme.of(context).inputTheme.decoration ??
                      const ShadDecoration())
                  .mergeWith(decoration),
          builder: (field) {
            final state = field as _ShadFormBuilderInputState;
            return ShadInput(
              key: state.inputKey,
              controller: state.controller,
              restorationId: restorationId,
              enabled: state.enabled,
              focusNode: state.focusNode,
              decoration: state.decoration,
              style: style,
              cursorColor: cursorColor,
              selectionColor: selectionColor,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              obscureText: obscureText,
              autocorrect: autocorrect,
              magnifierConfiguration: magnifierConfiguration,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              enableSuggestions: enableSuggestions,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmitted,
              onAppPrivateCommand: onAppPrivateCommand,
              inputFormatters: inputFormatters,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              scrollPadding: scrollPadding,
              dragStartBehavior: dragStartBehavior,
              scrollController: scrollController,
              scrollPhysics: scrollPhysics,
              autofillHints: autofillHints,
              clipBehavior: clipBehavior,
              scribbleEnabled: scribbleEnabled,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              contentInsertionConfiguration: contentInsertionConfiguration,
              contextMenuBuilder: contextMenuBuilder,
              selectionControls: selectionControls,
              mouseCursor: mouseCursor,
              enableInteractiveSelection: enableInteractiveSelection,
              undoController: undoController,
              spellCheckConfiguration: spellCheckConfiguration,
              hintText: hintText,
              onPressed: onPressed,
              onPressedAlwaysCalled: onPressedAlwaysCalled,
              onPressedOutside: onPressedOutside,
              keyboardAppearance: keyboardAppearance,
              cursorOpacityAnimates: cursorOpacityAnimates,
              readOnly: readOnly,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textDirection: textDirection,
              obscuringCharacter: obscuringCharacter,
              showCursor: showCursor,
              maxLength: maxLength,
              maxLengthEnforcement: maxLengthEnforcement,
              padding: padding,
              prefix: prefix,
              suffix: suffix,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              hintStyle: placeholderStyle,
              inputPadding: inputPadding,
              gap: gap,
            );
          },
        );

  final TextEditingController? controller;

  @override
  ShadFormBuilderFieldState<ShadInputFormField, String> createState() =>
      _ShadFormBuilderInputState();
}

class _ShadFormBuilderInputState
    extends ShadFormBuilderFieldState<ShadInputFormField, String> {
  TextEditingController? _controller;

  TextEditingController get controller => widget.controller ?? _controller!;
  final GlobalKey<ShadInputState> inputKey = GlobalKey<ShadInputState>();

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: value);
    }
    controller.addListener(onControllerChanged);
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (controller.text != value) {
      controller.text = value ?? '';
    }
  }

  @override
  void didUpdateWidget(covariant ShadInputFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == null && widget.controller != null) {
      _controller?.dispose();
    }
    if (oldWidget.controller != null && widget.controller == null) {
      _controller = TextEditingController(text: value);
    }
  }

  @override
  void reset() {
    super.reset();
    controller.text = initialValue ?? '';
    widget.onChanged?.call(controller.text);
  }

  @override
  void dispose() {
    controller.removeListener(onControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  void onControllerChanged() {
    if (controller.text != value) {
      didChange(controller.text);
    }
  }
}
