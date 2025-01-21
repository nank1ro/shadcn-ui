import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/src/components/disabled.dart';
import 'package:shadcn_ui/src/theme/components/decorator.dart';
import 'package:shadcn_ui/src/theme/theme.dart';
import 'package:shadcn_ui/src/utils/separated_iterable.dart';

class ShadInput extends StatefulWidget {
  const ShadInput({
    super.key,
    this.hintText,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.decoration,
    this.undoController,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onPressed,
    this.onPressedAlwaysCalled = false,
    this.onPressedOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
    this.selectionColor,
    this.padding,
    this.prefix,
    this.suffix,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.hintStyle,
    this.inputPadding,
    this.gap,
  })  : smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText),
        assert(
          initialValue == null || controller == null,
          'Either initialValue or controller must be specified',
        );

  final ShadDecoration? decoration;
  final String? initialValue;
  final String? hintText;
  final TextMagnifierConfiguration magnifierConfiguration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onPressed;
  final TapRegionCallback? onPressedOutside;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final Color? selectionColor;
  final EdgeInsets? padding;
  final Widget? prefix;
  final Widget? suffix;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? hintStyle;
  final EdgeInsets? inputPadding;
  final bool onPressedAlwaysCalled;
  final double? gap;

  static const int noMaxLength = -1;

  bool get selectionEnabled => enableInteractiveSelection;

  @override
  State<ShadInput> createState() => ShadInputState();
}

class ShadInputState extends State<ShadInput>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate {
  // ignore: use_late_for_private_fields_and_variables
  FocusNode? _focusNode;
  FocusNode get effectiveFocusNode => widget.focusNode ?? _focusNode!;
  final hasFocus = ValueNotifier(false);
  RestorableTextEditingController? _controller;
  TextEditingController get effectiveController =>
      widget.controller ?? _controller!.value;
  final TextEditingController hintTextEditingController =
      TextEditingController();
  bool _showSelectionHandles = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _focusNode = FocusNode(canRequestFocus: !widget.readOnly);
    }
    effectiveFocusNode.addListener(onFocusChange);

    if (widget.controller == null) {
      _createLocalController(TextEditingValue(text: widget.initialValue ?? ''));
    }
    hintTextEditingController.text = widget.hintText ?? '';
  }

  @override
  void didUpdateWidget(ShadInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(onFocusChange);
      effectiveFocusNode.addListener(onFocusChange);
    }
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.readOnly != oldWidget.readOnly) {
      _focusNode?.canRequestFocus = widget.readOnly;
    }

    if (effectiveFocusNode.hasFocus && widget.readOnly != oldWidget.readOnly) {
      if (effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
    if (oldWidget.hintText != widget.hintText) {
      hintTextEditingController.text = widget.hintText ?? '';
    }
  }

  @override
  void dispose() {
    effectiveFocusNode.removeListener(onFocusChange);

    if (widget.focusNode == null) effectiveFocusNode.dispose();
    _controller?.dispose();
    hintTextEditingController.dispose();
    super.dispose();
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  void onFocusChange() {
    hasFocus.value = effectiveFocusNode.hasFocus;
  }

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  late final _selectionGestureDetectorBuilder =
      _InputSelectionGestureDetectorBuilder(state: this);

  @override
  bool get forcePressEnabled {
    return switch (Theme.of(context).platform) {
      TargetPlatform.iOS => true,
      _ => false,
    };
  }

  @override
  bool get selectionEnabled => widget.enableInteractiveSelection;

  @override
  String? get restorationId => widget.restorationId;

  EditableTextState? get _editableText => editableTextKey.currentState;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) _registerController();
  }

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    final willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.extent);
        }
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
    }
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (widget.readOnly && effectiveController.selection.isCollapsed) {
      return false;
    }

    if (!widget.enabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress ||
        cause == SelectionChangedCause.scribble) {
      return true;
    }

    if (effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final effectiveTextStyle = theme.textTheme.muted
        .copyWith(
          color: theme.colorScheme.foreground,
        )
        .merge(theme.inputTheme.style)
        .merge(widget.style);

    final effectiveDecoration =
        (theme.inputTheme.decoration ?? const ShadDecoration())
            .mergeWith(widget.decoration);

    final effectivePadding = widget.padding ??
        theme.inputTheme.padding ??
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8);

    final effectiveInputPadding =
        widget.inputPadding ?? theme.inputTheme.inputPadding ?? EdgeInsets.zero;

    final effectivePlaceholderStyle = theme.textTheme.muted
        .merge(theme.inputTheme.placeholderStyle)
        .merge(widget.hintStyle);

    final effectiveMainAxisAlignment = widget.mainAxisAlignment ??
        theme.inputTheme.mainAxisAlignment ??
        MainAxisAlignment.start;

    final effectiveCrossAxisAlignment = widget.crossAxisAlignment ??
        theme.inputTheme.crossAxisAlignment ??
        CrossAxisAlignment.center;
    final effectiveMouseCursor =
        widget.mouseCursor ?? WidgetStateMouseCursor.textable;

    final effectiveGap = widget.gap ?? theme.inputTheme.gap ?? 8.0;

    final defaultSelectionControls = switch (Theme.of(context).platform) {
      TargetPlatform.iOS => cupertinoTextSelectionHandleControls,
      TargetPlatform.macOS => cupertinoDesktopTextSelectionHandleControls,
      TargetPlatform.android ||
      TargetPlatform.fuchsia =>
        materialTextSelectionHandleControls,
      TargetPlatform.linux ||
      TargetPlatform.windows =>
        desktopTextSelectionHandleControls,
    };
    final effectiveSelectionControls =
        widget.selectionControls ?? defaultSelectionControls;

    final effectiveContextMenuBuilder = widget.contextMenuBuilder ??
        (context, editableState) {
          return AdaptiveTextSelectionToolbar.editableText(
            editableTextState: _editableText!,
          );
        };

    final effectiveMaxLengthEnforcement = widget.maxLengthEnforcement ??
        LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(
          Theme.of(context).platform,
        );

    final effectiveInputFormatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: effectiveMaxLengthEnforcement,
        ),
    ];

    return ShadDisabled(
      disabled: !widget.enabled,
      child: _selectionGestureDetectorBuilder.buildGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: ValueListenableBuilder(
          valueListenable: hasFocus,
          builder: (context, focused, _) {
            return ValueListenableBuilder(
              valueListenable: effectiveController,
              builder: (context, textEditingValue, child) {
                final showHint =
                    textEditingValue.text.isEmpty && widget.hintText != null;
                return ShadDecorator(
                  decoration: effectiveDecoration,
                  focused: focused,
                  child: Padding(
                    padding: effectivePadding,
                    child: Row(
                      mainAxisAlignment: effectiveMainAxisAlignment,
                      crossAxisAlignment: effectiveCrossAxisAlignment,
                      children: [
                        if (widget.prefix != null) widget.prefix!,
                        Flexible(
                          child: AbsorbPointer(
                            // AbsorbPointer is needed when the input is
                            // readOnly so the onTap callback is fired on each
                            // part of the input
                            absorbing: widget.readOnly,
                            child: Padding(
                              padding: effectiveInputPadding,
                              child: Stack(
                                children: [
                                  // placeholder
                                  Offstage(
                                    offstage: !showHint,
                                    child: RepaintBoundary(
                                      child: UnmanagedRestorationScope(
                                        bucket: bucket,
                                        child: EditableText(
                                          controller: hintTextEditingController,
                                          readOnly: true,
                                          focusNode: effectiveFocusNode,
                                          style: effectivePlaceholderStyle,
                                          strutStyle: widget.strutStyle,
                                          cursorColor: widget.cursorColor ??
                                              theme.colorScheme.primary,
                                          backgroundCursorColor: Colors.grey,
                                          maxLines: widget.maxLines,
                                          minLines: widget.minLines,
                                          expands: widget.expands,
                                          clipBehavior: widget.clipBehavior,
                                          restorationId: 'editable_hint',
                                          textAlign: widget.textAlign,
                                          rendererIgnoresPointer: true,
                                          showCursor: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                  RepaintBoundary(
                                    child: UnmanagedRestorationScope(
                                      bucket: bucket,
                                      child: Offstage(
                                        offstage: showHint,
                                        child: EditableText(
                                          showSelectionHandles:
                                              _showSelectionHandles,
                                          key: editableTextKey,
                                          controller: effectiveController,
                                          obscuringCharacter:
                                              widget.obscuringCharacter,
                                          readOnly: widget.readOnly,
                                          focusNode: effectiveFocusNode,
                                          // ! Selection handler section here
                                          onSelectionChanged:
                                              _handleSelectionChanged,
                                          selectionColor: focused
                                              ? widget.selectionColor ??
                                                  theme.colorScheme.selection
                                              : null,
                                          selectionHeightStyle:
                                              widget.selectionHeightStyle,
                                          selectionWidthStyle:
                                              widget.selectionWidthStyle,
                                          contextMenuBuilder:
                                              effectiveContextMenuBuilder,
                                          selectionControls:
                                              effectiveSelectionControls,
                                          // ! End of selection handler section
                                          mouseCursor: effectiveMouseCursor,
                                          enableInteractiveSelection:
                                              widget.enableInteractiveSelection,
                                          style: effectiveTextStyle,
                                          strutStyle: widget.strutStyle,
                                          cursorColor: widget.cursorColor ??
                                              theme.colorScheme.primary,
                                          backgroundCursorColor: Colors.grey,
                                          keyboardType: widget.keyboardType,
                                          keyboardAppearance:
                                              widget.keyboardAppearance ??
                                                  theme.brightness,
                                          textInputAction:
                                              widget.textInputAction,
                                          textCapitalization:
                                              widget.textCapitalization,
                                          autofocus: widget.autofocus,
                                          obscureText: widget.obscureText,
                                          autocorrect: widget.autocorrect,
                                          magnifierConfiguration:
                                              widget.magnifierConfiguration,
                                          smartDashesType:
                                              widget.smartDashesType,
                                          smartQuotesType:
                                              widget.smartQuotesType,
                                          enableSuggestions:
                                              widget.enableSuggestions,
                                          maxLines: widget.maxLines,
                                          minLines: widget.minLines,
                                          expands: widget.expands,
                                          onChanged: widget.onChanged,
                                          onEditingComplete:
                                              widget.onEditingComplete,
                                          onSubmitted: widget.onSubmitted,
                                          onAppPrivateCommand:
                                              widget.onAppPrivateCommand,
                                          inputFormatters:
                                              effectiveInputFormatters,
                                          cursorWidth: widget.cursorWidth,
                                          cursorHeight: widget.cursorHeight,
                                          cursorRadius: widget.cursorRadius,
                                          scrollPadding: widget.scrollPadding,
                                          dragStartBehavior:
                                              widget.dragStartBehavior,
                                          scrollController:
                                              widget.scrollController,
                                          scrollPhysics: widget.scrollPhysics,
                                          autofillHints: widget.autofillHints,
                                          clipBehavior: widget.clipBehavior,
                                          restorationId: 'editable',
                                          scribbleEnabled:
                                              widget.scribbleEnabled,
                                          enableIMEPersonalizedLearning: widget
                                              .enableIMEPersonalizedLearning,
                                          contentInsertionConfiguration: widget
                                              .contentInsertionConfiguration,
                                          undoController: widget.undoController,
                                          spellCheckConfiguration:
                                              widget.spellCheckConfiguration,
                                          textAlign: widget.textAlign,
                                          onTapOutside: widget.onPressedOutside,
                                          rendererIgnoresPointer: true,
                                          showCursor: widget.showCursor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (widget.suffix != null) widget.suffix!,
                      ].separatedBy(SizedBox(width: effectiveGap)),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InputSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _InputSelectionGestureDetectorBuilder({
    required ShadInputState state,
  })  : _state = state,
        super(delegate: state);

  final ShadInputState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onUserTap() {
    _state.widget.onPressed?.call();
  }

  @override
  bool get onUserTapAlwaysCalled => _state.widget.onPressedAlwaysCalled;

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}
