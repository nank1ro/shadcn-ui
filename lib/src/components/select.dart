import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shadcn_ui/src/components/disabled.dart';
import 'package:shadcn_ui/src/components/input.dart';
import 'package:shadcn_ui/src/components/popover.dart';
import 'package:shadcn_ui/src/raw_components/focusable.dart';
import 'package:shadcn_ui/src/raw_components/portal.dart';
import 'package:shadcn_ui/src/theme/components/decorator.dart';
import 'package:shadcn_ui/src/theme/components/select.dart';
import 'package:shadcn_ui/src/theme/theme.dart';
import 'package:shadcn_ui/src/utils/debug_check.dart';
import 'package:shadcn_ui/src/utils/extensions/order_policy.dart';
import 'package:shadcn_ui/src/utils/gesture_detector.dart';
import 'package:shadcn_ui/src/utils/provider.dart';

typedef ShadSelectedOptionBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);

enum ShadSelectVariant { primary, search, multiple, multipleWithSearch }

class ShadSelect<T> extends StatefulWidget {
  const ShadSelect({
    super.key,
    this.options,
    this.optionsBuilder,
    this.selectedOptionBuilder,
    this.selectedOptionsBuilder,
    this.controller,
    this.enabled = true,
    this.placeholder,
    this.initialValue,
    this.initialValues = const [],
    this.onChanged,
    this.focusNode,
    this.closeOnTapOutside = true,
    this.minWidth,
    this.maxWidth,
    this.maxHeight,
    this.decoration,
    this.trailing,
    this.padding,
    this.optionsPadding,
    this.showScrollToBottomChevron,
    this.showScrollToTopChevron,
    this.scrollController,
    this.anchor,
    this.effects,
    this.shadows,
    this.filter,
    this.header,
    this.footer,
    this.closeOnSelect = true,
    this.allowDeselection = false,
    this.groupId,
    this.itemCount,
    this.shrinkWrap,
  })  : variant = ShadSelectVariant.primary,
        onSearchChanged = null,
        searchDivider = null,
        searchHintText = null,
        searchInputPrefix = null,
        onMultipleChanged = null,
        searchPadding = null,
        search = null,
        clearSearchOnClose = false,
        assert(
          options != null || optionsBuilder != null,
          'Either options or optionsBuilder must be provided',
        ),
        assert(
          (selectedOptionBuilder != null) ^ (selectedOptionsBuilder != null),
          '''Either selectedOptionBuilder or selectedOptionsBuilder must be provided''',
        );

  const ShadSelect.withSearch({
    super.key,
    this.options,
    this.optionsBuilder,
    this.selectedOptionBuilder,
    required ValueChanged<String> this.onSearchChanged,
    this.onChanged,
    this.controller,
    this.searchDivider,
    this.searchInputPrefix,
    this.searchHintText,
    this.searchPadding,
    this.search,
    this.clearSearchOnClose,
    this.enabled = true,
    this.placeholder,
    this.initialValue,
    this.initialValues = const [],
    this.focusNode,
    this.closeOnTapOutside = true,
    this.minWidth,
    this.maxWidth,
    this.maxHeight,
    this.decoration,
    this.trailing,
    this.padding,
    this.optionsPadding,
    this.showScrollToBottomChevron,
    this.showScrollToTopChevron,
    this.scrollController,
    this.anchor,
    this.effects,
    this.shadows,
    this.filter,
    this.header,
    this.footer,
    this.closeOnSelect = true,
    this.allowDeselection = false,
    this.groupId,
    this.itemCount,
    this.shrinkWrap,
  })  : variant = ShadSelectVariant.search,
        selectedOptionsBuilder = null,
        onMultipleChanged = null,
        assert(
          options != null || optionsBuilder != null,
          'Either options or optionsBuilder must be provided',
        );

  const ShadSelect.multiple({
    super.key,
    this.options,
    this.optionsBuilder,
    required this.selectedOptionsBuilder,
    this.controller,
    this.enabled = true,
    this.placeholder,
    this.initialValues = const [],
    ValueChanged<List<T>>? onChanged,
    this.focusNode,
    this.closeOnTapOutside = true,
    this.minWidth,
    this.maxWidth,
    this.maxHeight,
    this.decoration,
    this.trailing,
    this.padding,
    this.optionsPadding,
    this.showScrollToBottomChevron,
    this.showScrollToTopChevron,
    this.scrollController,
    this.anchor,
    this.effects,
    this.shadows,
    this.filter,
    this.header,
    this.footer,
    this.allowDeselection = true,
    this.closeOnSelect = true,
    this.groupId,
    this.itemCount,
    this.shrinkWrap,
  })  : variant = ShadSelectVariant.multiple,
        onSearchChanged = null,
        initialValue = null,
        selectedOptionBuilder = null,
        searchDivider = null,
        searchHintText = null,
        searchInputPrefix = null,
        searchPadding = null,
        search = null,
        clearSearchOnClose = false,
        onChanged = null,
        onMultipleChanged = onChanged,
        assert(
          options != null || optionsBuilder != null,
          'Either options or optionsBuilder must be provided',
        );

  const ShadSelect.multipleWithSearch({
    super.key,
    this.options,
    this.optionsBuilder,
    required ValueChanged<String> this.onSearchChanged,
    required this.selectedOptionsBuilder,
    ValueChanged<List<T>>? onChanged,
    this.controller,
    this.searchDivider,
    this.searchInputPrefix,
    this.searchHintText,
    this.searchPadding,
    this.search,
    this.clearSearchOnClose,
    this.enabled = true,
    this.placeholder,
    this.initialValues = const [],
    this.focusNode,
    this.closeOnTapOutside = true,
    this.minWidth,
    this.maxWidth,
    this.maxHeight,
    this.decoration,
    this.trailing,
    this.padding,
    this.optionsPadding,
    this.showScrollToBottomChevron,
    this.showScrollToTopChevron,
    this.scrollController,
    this.anchor,
    this.effects,
    this.shadows,
    this.filter,
    this.header,
    this.footer,
    this.allowDeselection = true,
    this.closeOnSelect = true,
    this.groupId,
    this.itemCount,
    this.shrinkWrap,
  })  : variant = ShadSelectVariant.multipleWithSearch,
        selectedOptionBuilder = null,
        onChanged = null,
        onMultipleChanged = onChanged,
        initialValue = null,
        assert(
          options != null || optionsBuilder != null,
          'Either options or optionsBuilder must be provided',
        );

  const ShadSelect.raw({
    super.key,
    required this.variant,
    this.options,
    this.optionsBuilder,
    this.selectedOptionBuilder,
    this.selectedOptionsBuilder,
    this.controller,
    this.onSearchChanged,
    this.searchDivider,
    this.searchInputPrefix,
    this.searchHintText,
    this.searchPadding,
    this.search,
    this.clearSearchOnClose,
    this.enabled = true,
    this.placeholder,
    this.initialValue,
    this.initialValues = const [],
    this.onChanged,
    this.onMultipleChanged,
    this.focusNode,
    this.closeOnTapOutside = true,
    this.minWidth,
    this.maxWidth,
    this.maxHeight,
    this.decoration,
    this.trailing,
    this.padding,
    this.optionsPadding,
    this.showScrollToBottomChevron,
    this.showScrollToTopChevron,
    this.scrollController,
    this.anchor,
    this.effects,
    this.shadows,
    this.filter,
    this.header,
    this.footer,
    this.allowDeselection = false,
    this.closeOnSelect = true,
    this.groupId,
    this.itemCount,
    this.shrinkWrap,
  })  : assert(
          variant == ShadSelectVariant.primary || onSearchChanged != null,
          'onSearchChanged must be provided when variant is search',
        ),
        assert(
          options != null || optionsBuilder != null,
          'Either options or optionsBuilder must be provided',
        ),
        assert(
          (selectedOptionBuilder != null) ^ (selectedOptionsBuilder != null),
          '''Either selectedOptionBuilder or selectedOptionsBuilder must be provided''',
        );

  /// The callback that is called when the value of the [ShadSelect] changes.
  final ValueChanged<T?>? onChanged;

  /// {@template ShadSelect.onMultipleChanged}
  /// The callback that is called when the values of the [ShadSelect] changes.
  /// Called only the variant is [ShadSelect.multiple].
  /// {@endtemplate}
  final ValueChanged<List<T>>? onMultipleChanged;

  /// {@template ShadSelect.allowDeselection}
  /// Whether the [ShadSelect] allows deselection, defaults to
  /// `false`.
  /// {@endtemplate}
  final bool allowDeselection;

  /// Whether the [ShadSelect] is enabled, defaults to true.
  final bool enabled;

  /// The initial value of the [ShadSelect], defaults to `null`.
  final T? initialValue;

  /// {@template ShadSelect.initialValues}
  /// The initial values of the [ShadSelect], defaults to `[]`.
  /// {@endtemplate}
  final List<T> initialValues;

  /// The placeholder of the [ShadSelect], displayed when the value is null.
  final Widget? placeholder;

  /// The builder for the selected option of the [ShadSelect].
  final ShadSelectedOptionBuilder<T>? selectedOptionBuilder;

  /// The builder for the selected options of the [ShadSelect].
  final ShadSelectedOptionBuilder<List<T>>? selectedOptionsBuilder;

  /// The options of the [ShadSelect].
  ///
  /// Use `optionsBuilder` instead if you have a large number of options.
  final Iterable<Widget>? options;

  /// The builder for the options of the [ShadSelect].
  final Widget? Function(BuildContext, int)? optionsBuilder;

  /// The focus node of the [ShadSelect].
  final FocusNode? focusNode;

  /// Whether to close the [ShadSelect] when the user taps outside of it,
  /// defaults to `true`.
  final bool closeOnTapOutside;

  /// The minimum width of the [ShadSelect], defaults to
  /// `max(kDefaultSelectMinWidth, constraints.minWidth)`.
  ///
  /// This value is not guaranteed to be respected, because the effective
  /// minWidth is calculated from the max of this value and the min width of the
  /// view itself.
  final double? minWidth;

  /// The maximum width of the [ShadSelect], defaults to
  /// `double.infinity`.
  final double? maxWidth;

  /// The maximum height of the [ShadSelect], defaults to
  /// `kDefaultSelectMaxHeight`.
  final double? maxHeight;

  /// The decoration of the [ShadSelect].
  final ShadDecoration? decoration;

  /// The trailing widget of the [ShadSelect], defaults to a chevron-right
  /// icon.
  final Widget? trailing;

  /// The padding of the [ShadSelect], defaults to
  /// `EdgeInsets.symmetric(horizontal: 12, vertical: 8)`.
  final EdgeInsets? padding;

  /// The padding of the options of the [ShadSelect], defaults to
  /// `EdgeInsets.all(4)`.
  final EdgeInsets? optionsPadding;

  /// Whether to show the scroll-to-top chevron, defaults to true.
  final bool? showScrollToTopChevron;

  /// Whether to show the scroll-to-bottom chevron, defaults to true.
  final bool? showScrollToBottomChevron;

  /// The scroll controller of the [ShadSelect].
  final ScrollController? scrollController;

  /// The anchor of the [ShadSelect], defaults to
  /// `ShadAnchorAutoPosition(verticalOffset: 24, preferBelow: true)`.
  final ShadAnchorBase? anchor;

  /// The type of the [ShadSelect], defaults to `ShadSelectType.primary`.
  final ShadSelectVariant variant;

  /// The callback that is called when the search value changes.
  final ValueChanged<String>? onSearchChanged;

  /// The widget that is displayed between the search input and the options.
  final Widget? searchDivider;

  /// The prefix of the search input.
  final Widget? searchInputPrefix;

  /// The hinText of the search input.
  final String? searchHintText;

  /// The padding of the search input.
  final EdgeInsets? searchPadding;

  /// A complete customizable search input.
  final Widget? search;

  /// Whether to clear the search input when the popover is closed, defaults to
  /// `true`.
  final bool? clearSearchOnClose;

  /// {@macro ShadPopover.effects}
  final List<Effect<dynamic>>? effects;

  /// {@macro ShadPopover.shadows}
  final List<BoxShadow>? shadows;

  /// {@macro ShadPopover.filter}
  final ImageFilter? filter;

  /// {@macro ShadPopover.controller}
  final ShadPopoverController? controller;

  /// {@template ShadSelect.header}
  /// The header of the [ShadSelect].
  /// {@endtemplate}
  final Widget? header;

  /// {@template ShadSelect.footer}
  /// The footer of the [ShadSelect].
  /// {@endtemplate}
  final Widget? footer;

  /// {@template ShadSelect.closeOnSelect}
  /// Whether to close the [ShadSelect] when a value is selected.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool closeOnSelect;

  /// {@macro ShadPopover.groupId}
  final Object? groupId;

  /// {@template ShadSelect.itemCount}
  /// The number of items in the options, used in combination with
  /// [optionsBuilder].
  /// {@endtemplate}
  final int? itemCount;

  /// {@template ShadSelect.shrinkWrap}
  /// Whether the options returned by [optionsBuilder] should shrink wrap,
  /// defaults to `false`.
  /// You may set it to `true` when the [itemCount] provided is small and you
  /// want the content to be resized.
  /// {@endtemplate}
  final bool? shrinkWrap;

  @override
  ShadSelectState<T> createState() => ShadSelectState();
}

class ShadSelectState<T> extends State<ShadSelect<T>> {
  FocusNode? internalFocusNode;
  late final selectedValues = <T>{
    if (widget.initialValue is T) widget.initialValue as T,
    ...widget.initialValues,
  };

  ShadPopoverController? _controller;

  ShadPopoverController get controller =>
      widget.controller ?? (_controller ??= ShadPopoverController());

  ScrollController? _scrollController;

  final showScrollToBottom = ValueNotifier(false);
  final showScrollToTop = ValueNotifier(false);
  bool shouldAnimateToTop = false;
  bool shouldAnimateToBottom = false;

  FocusNode get focusNode => widget.focusNode ?? internalFocusNode!;

  ScrollController get scrollController =>
      widget.scrollController ?? _scrollController!;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _scrollController = ScrollController();
    }
    if (widget.focusNode == null) internalFocusNode = FocusNode();

    // react to the scroll position
    scrollController.addListener(() {
      if (!scrollController.hasClients) return;
      showScrollToBottom.value =
          scrollController.offset < scrollController.position.maxScrollExtent;
      showScrollToTop.value = scrollController.offset > 0;
    });

    if (widget.variant == ShadSelectVariant.search) {
      controller.addListener(() {
        if (controller.isOpen) return;
        final effectiveClearSearchOnClose = widget.clearSearchOnClose ??
            ShadTheme.of(context, listen: false)
                .selectTheme
                .clearSearchOnClose ??
            true;

        if (effectiveClearSearchOnClose) {
          widget.onSearchChanged?.call('');
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant ShadSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      if (widget.initialValue is T) {
        selectedValues
          ..clear()
          ..add(widget.initialValue as T);
      }
    }
    if (widget.initialValues != oldWidget.initialValues) {
      selectedValues
        ..clear()
        ..addAll(widget.initialValues);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    internalFocusNode?.dispose();
    _scrollController?.dispose();
    showScrollToBottom.dispose();
    showScrollToTop.dispose();
    super.dispose();
  }

  Future<void> animateToTop() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    while (shouldAnimateToTop) {
      shouldAnimateToTop = scrollController.offset > 0;
      await scrollController.animateTo(
        max(scrollController.offset - 30, 0),
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> animateToBottom() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    while (shouldAnimateToBottom) {
      shouldAnimateToBottom =
          scrollController.offset < scrollController.position.maxScrollExtent;
      await scrollController.animateTo(
        min(
          scrollController.offset + 30,
          scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void select(T value) {
    final isMultiSelection = widget.variant == ShadSelectVariant.multiple ||
        widget.variant == ShadSelectVariant.multipleWithSearch;

    final prevList = selectedValues.toList(growable: false);
    if (widget.closeOnSelect) controller.hide();
    setState(() {
      if (!isMultiSelection) selectedValues.clear();
      if (widget.allowDeselection && prevList.contains(value)) {
        selectedValues.remove(value);
      } else {
        selectedValues.add(value);
      }
    });

    final newList = selectedValues.toList(growable: false);
    final changed = !ListEquality<T>().equals(prevList, newList);

    if (widget.closeOnSelect) {
      focusNode.requestFocus();
    }

    if (changed) {
      if (isMultiSelection) {
        widget.onMultipleChanged?.call(selectedValues.toList());
      } else {
        widget.onChanged?.call(selectedValues.firstOrNull);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasShadTheme(context));
    final theme = ShadTheme.of(context);

    final effectiveDecoration = theme.decoration
        .mergeWith(theme.selectTheme.decoration)
        .mergeWith(widget.decoration);

    final decorationHorizontalPadding =
        (effectiveDecoration.border?.padding?.horizontal ?? 0.0) +
            (effectiveDecoration.secondaryBorder?.padding?.horizontal ?? 0.0);

    final effectivePadding = widget.padding ??
        theme.selectTheme.padding ??
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8);

    final effectiveShowScrollToTopChevron = widget.showScrollToTopChevron ??
        theme.selectTheme.showScrollToTopChevron ??
        true;

    final effectiveShowScrollToBottomChevron =
        widget.showScrollToBottomChevron ??
            theme.selectTheme.showScrollToBottomChevron ??
            true;

    final effectiveAnchor =
        widget.anchor ?? theme.selectTheme.anchor ?? const ShadAnchor();

    final effectiveEffects = widget.effects ?? theme.selectTheme.effects;

    final effectiveShadows = widget.shadows ?? theme.selectTheme.shadows;

    final effectiveFilter = widget.filter ?? theme.selectTheme.filter;

    final isMultiSelect = widget.selectedOptionsBuilder != null;

    final Widget effectiveText;
    if (selectedValues.isNotEmpty) {
      switch (isMultiSelect) {
        case true:
          effectiveText =
              widget.selectedOptionsBuilder!(context, selectedValues.toList());
        case false:
          effectiveText = widget.selectedOptionBuilder!(
            context,
            selectedValues.first,
          );
      }
    } else {
      assert(
        widget.placeholder != null,
        'placeholder must not be null when value is null',
      );
      effectiveText = widget.placeholder!;
    }

    final effectiveTrailing = widget.trailing ??
        Icon(
          LucideIcons.chevronDown,
          size: 16,
          color: theme.colorScheme.popoverForeground.withValues(alpha: .5),
        );

    final effectiveMinWidth =
        widget.minWidth ?? theme.selectTheme.minWidth ?? kDefaultSelectMinWidth;
    final effectiveMaxWidth =
        widget.maxWidth ?? theme.selectTheme.maxWidth ?? double.infinity;
    final effectiveMaxHeight = widget.maxHeight ??
        theme.selectTheme.maxHeight ??
        kDefaultSelectMaxHeight;
    final effectiveOptionsPadding = widget.optionsPadding ??
        theme.selectTheme.optionsPadding ??
        const EdgeInsets.all(4);

    final search = switch (widget.variant) {
      ShadSelectVariant.primary || ShadSelectVariant.multiple => null,
      ShadSelectVariant.search ||
      ShadSelectVariant.multipleWithSearch =>
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.search ??
                ShadInput(
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      LucideIcons.search,
                      size: 16,
                      color: theme.colorScheme.popoverForeground,
                    ),
                  ),
                  padding: widget.searchPadding ??
                      theme.selectTheme.searchPadding ??
                      const EdgeInsets.all(12),
                  hintText: widget.searchHintText,
                  decoration: ShadDecoration.none,
                  onChanged: widget.onSearchChanged,
                ),
            widget.searchDivider ?? const Divider(height: 1),
          ],
        ),
    };

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): controller.toggle,
        const SingleActivator(LogicalKeyboardKey.escape): controller.hide,
      },
      child: FocusTraversalGroup(
        policy: WidgetOrderTraversalPolicy(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final calculatedMinWidth =
                max(effectiveMinWidth, constraints.minWidth) -
                    decorationHorizontalPadding;

            final effectiveConstraints = BoxConstraints(
              minWidth: calculatedMinWidth,
              maxWidth: effectiveMaxWidth,
            );

            late final Widget effectiveChild;

            if (widget.options != null) {
              effectiveChild = SingleChildScrollView(
                padding: effectiveOptionsPadding,
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: widget.options!.toList(),
                ),
              );
            } else {
              effectiveChild = ListView.builder(
                padding: effectiveOptionsPadding,
                controller: scrollController,
                itemCount: widget.itemCount,
                shrinkWrap: widget.shrinkWrap ?? false,
                itemBuilder: (context, index) {
                  return widget.optionsBuilder?.call(context, index);
                },
              );
            }

            final Widget select = ShadDisabled(
              disabled: !widget.enabled,
              child: ShadFocusable(
                canRequestFocus: widget.enabled,
                focusNode: focusNode,
                builder: (context, focused, child) {
                  return ShadDecorator(
                    focused: focused,
                    decoration: effectiveDecoration,
                    child: child,
                  );
                },
                child: ShadGestureDetector(
                  cursor: SystemMouseCursors.click,
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.toggle();
                  },
                  child: ConstrainedBox(
                    constraints: effectiveConstraints,
                    child: Padding(
                      padding: effectivePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: DefaultTextStyle(
                              style: theme.textTheme.muted.copyWith(
                                color: theme.colorScheme.foreground,
                              ),
                              child: effectiveText,
                            ),
                          ),
                          effectiveTrailing,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

            final scrollToTopChild = effectiveShowScrollToTopChevron
                ? ValueListenableBuilder(
                    valueListenable: showScrollToTop,
                    builder: (context, show, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: show
                            ? MouseRegion(
                                onEnter: (_) {
                                  shouldAnimateToTop = true;
                                  animateToTop();
                                },
                                onExit: (_) => shouldAnimateToTop = false,
                                child: Container(
                                  width: calculatedMinWidth,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Icon(
                                    LucideIcons.chevronUp,
                                    size: 16,
                                    color: theme.colorScheme.popoverForeground,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      );
                    },
                  )
                : null;

            final scrollToBottomChild = effectiveShowScrollToBottomChevron
                ? ValueListenableBuilder(
                    valueListenable: showScrollToBottom,
                    builder: (context, show, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: show
                            ? MouseRegion(
                                onEnter: (_) {
                                  shouldAnimateToBottom = true;
                                  animateToBottom();
                                },
                                onExit: (_) => shouldAnimateToBottom = false,
                                child: Container(
                                  width: calculatedMinWidth,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Icon(
                                    LucideIcons.chevronDown,
                                    size: 16,
                                    color: theme.colorScheme.popoverForeground,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      );
                    },
                  )
                : null;

            return ShadProvider(
              data: this as ShadSelectState<dynamic>,
              notifyUpdate: (_) => true,
              child: ShadPopover(
                groupId: widget.groupId,
                padding: EdgeInsets.zero,
                controller: controller,
                anchor: effectiveAnchor,
                closeOnTapOutside: widget.closeOnTapOutside,
                effects: effectiveEffects,
                shadows: effectiveShadows,
                filter: effectiveFilter,
                popover: (_) {
                  // set the initial value for showScrollToBottom and
                  // showScrollToTop, after the popover is rendered
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    if (scrollController.hasClients) {
                      showScrollToBottom.value = scrollController.offset <
                          scrollController.position.maxScrollExtent;
                      showScrollToTop.value = scrollController.offset > 0;
                    }
                  });

                  Widget effectiveColumn = Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (search != null)
                        Flexible(
                          child: ConstrainedBox(
                            constraints: effectiveConstraints,
                            child: search,
                          ),
                        ),
                      if (widget.header != null)
                        Flexible(
                          child: ConstrainedBox(
                            constraints: effectiveConstraints,
                            child: widget.header,
                          ),
                        ),
                      if (scrollToTopChild != null) scrollToTopChild,
                      Flexible(
                        child: ConstrainedBox(
                          constraints: effectiveConstraints,
                          child: effectiveChild,
                        ),
                      ),
                      if (scrollToBottomChild != null) scrollToBottomChild,
                      if (widget.footer != null)
                        Flexible(
                          child: ConstrainedBox(
                            constraints: effectiveConstraints,
                            child: widget.footer,
                          ),
                        ),
                    ],
                  );

                  if (widget.optionsBuilder == null) {
                    effectiveColumn = IntrinsicWidth(child: effectiveColumn);
                  }

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: effectiveMaxHeight,
                      minWidth: calculatedMinWidth,
                      maxWidth: effectiveMaxWidth,
                    ),
                    child: effectiveColumn,
                  );
                },
                child: select,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShadOption<T> extends StatefulWidget {
  const ShadOption({
    super.key,
    required this.value,
    required this.child,
    this.hoveredBackgroundColor,
    this.padding,
    this.selectedIcon,
    this.radius,
    this.orderPolicy,
  });

  /// The value of the [ShadOption], it must be unique above the options.
  final T value;

  /// The child widget.
  final Widget child;

  /// The background color of the [ShadOption] when hovered, defaults to
  /// `ShadThemeData.accent`.
  final Color? hoveredBackgroundColor;

  /// The padding of the [ShadOption], defaults to
  /// `EdgeInsets.symmetric(horizontal: 8, vertical: 6)`
  final EdgeInsets? padding;

  /// The icon of the [ShadOption] when selected.
  final Widget? selectedIcon;

  /// The radius of the [ShadOption], defaults to `ShadThemeData.radius`.
  final BorderRadius? radius;

  /// {@template ShadOption.orderPolicy}
  /// The order policy of the items that compose the option, defaults to
  /// [WidgetOrderPolicy.linear()].
  /// {@endtemplate}
  final WidgetOrderPolicy? orderPolicy;

  @override
  State<ShadOption<T>> createState() => _ShadOptionState<T>();
}

class _ShadOptionState<T> extends State<ShadOption<T>> {
  final hovered = ValueNotifier(false);
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    final inherited =
        context.read<ShadSelectState<dynamic>>() as ShadSelectState<T>;
    final selected = inherited.selectedValues.contains(widget.value);
    if (selected) focusNode.requestFocus();
  }

  @override
  void dispose() {
    focusNode
      ..removeListener(onFocusChange)
      ..dispose();
    hovered.dispose();
    super.dispose();
  }

  void onFocusChange() {
    hovered.value = focusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final inheritedSelect =
        context.watch<ShadSelectState<dynamic>>() as ShadSelectState<T>;
    final selected = inheritedSelect.selectedValues.contains(widget.value);

    if (selected) {
      // scroll to the selected option
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Scrollable.maybeOf(context)
            ?.position
            .ensureVisible(context.findRenderObject()!);
      });
    }

    final effectiveHoveredBackgroundColor = widget.hoveredBackgroundColor ??
        theme.optionTheme.hoveredBackgroundColor ??
        theme.colorScheme.accent;
    final effectivePadding = widget.padding ??
        theme.optionTheme.padding ??
        const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
    final effectiveRadius =
        widget.radius ?? theme.optionTheme.radius ?? theme.radius;

    final effectiveOrderPolicy = widget.orderPolicy ??
        theme.selectTheme.optionsOrderPolicy ??
        const WidgetOrderPolicy.linear();

    final effectiveSelectedIcon = widget.selectedIcon ??
        Visibility.maintain(
          visible: selected,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              LucideIcons.check,
              size: 16,
              color: theme.colorScheme.popoverForeground,
            ),
          ),
        );

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): () {
          inheritedSelect.select(widget.value);
        },
      },
      child: Focus(
        focusNode: focusNode,
        child: ShadGestureDetector(
          behavior: HitTestBehavior.opaque,
          cursor: SystemMouseCursors.click,
          onHoverChange: (value) {
            hovered.value = value;
          },
          onTap: () => inheritedSelect.select(widget.value),
          child: ValueListenableBuilder(
            valueListenable: hovered,
            builder: (context, hovered, child) {
              return Container(
                padding: effectivePadding,
                decoration: BoxDecoration(
                  color: hovered ? effectiveHoveredBackgroundColor : null,
                  borderRadius: effectiveRadius,
                ),
                child: child,
              );
            },
            child: Row(
              children: [
                effectiveSelectedIcon,
                Expanded(
                  child: DefaultTextStyle(
                    style: theme.textTheme.muted.copyWith(
                      color: theme.colorScheme.popoverForeground,
                    ),
                    child: widget.child,
                  ),
                ),
              ].order(effectiveOrderPolicy),
            ),
          ),
        ),
      ),
    );
  }
}
