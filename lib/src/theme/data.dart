import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/src/theme/color_scheme/base.dart';
import 'package:shadcn_ui/src/theme/components/accordion.dart';
import 'package:shadcn_ui/src/theme/components/alert.dart';
import 'package:shadcn_ui/src/theme/components/avatar.dart';
import 'package:shadcn_ui/src/theme/components/badge.dart';
import 'package:shadcn_ui/src/theme/components/button.dart';
import 'package:shadcn_ui/src/theme/components/calendar.dart';
import 'package:shadcn_ui/src/theme/components/card.dart';
import 'package:shadcn_ui/src/theme/components/checkbox.dart';
import 'package:shadcn_ui/src/theme/components/context_menu.dart';
import 'package:shadcn_ui/src/theme/components/date_picker.dart';
import 'package:shadcn_ui/src/theme/components/decorator.dart';
import 'package:shadcn_ui/src/theme/components/dialog.dart';
import 'package:shadcn_ui/src/theme/components/input.dart';
import 'package:shadcn_ui/src/theme/components/input_otp.dart';
import 'package:shadcn_ui/src/theme/components/menubar.dart';
import 'package:shadcn_ui/src/theme/components/option.dart';
import 'package:shadcn_ui/src/theme/components/popover.dart';
import 'package:shadcn_ui/src/theme/components/progress.dart';
import 'package:shadcn_ui/src/theme/components/radio.dart';
import 'package:shadcn_ui/src/theme/components/resizable.dart';
import 'package:shadcn_ui/src/theme/components/select.dart';
import 'package:shadcn_ui/src/theme/components/sheet.dart';
import 'package:shadcn_ui/src/theme/components/slider.dart';
import 'package:shadcn_ui/src/theme/components/switch.dart';
import 'package:shadcn_ui/src/theme/components/table.dart';
import 'package:shadcn_ui/src/theme/components/tabs.dart';
import 'package:shadcn_ui/src/theme/components/time_picker.dart';
import 'package:shadcn_ui/src/theme/components/toast.dart';
import 'package:shadcn_ui/src/theme/components/tooltip.dart';
import 'package:shadcn_ui/src/theme/text_theme/theme.dart';
import 'package:shadcn_ui/src/theme/themes/base.dart';
import 'package:shadcn_ui/src/theme/themes/default_theme_no_secondary_border_variant.dart';
import 'package:shadcn_ui/src/theme/themes/default_theme_variant.dart';
import 'package:shadcn_ui/src/utils/gesture_detector.dart';
import 'package:shadcn_ui/src/utils/responsive.dart';

@immutable
class ShadThemeData extends ShadBaseTheme {
  factory ShadThemeData({
    required ShadColorScheme colorScheme,
    required Brightness brightness,
    Iterable<ThemeExtension<dynamic>>? extensions,
    ShadButtonTheme? primaryButtonTheme,
    ShadButtonTheme? secondaryButtonTheme,
    ShadButtonTheme? destructiveButtonTheme,
    ShadButtonTheme? outlineButtonTheme,
    ShadButtonTheme? ghostButtonTheme,
    ShadButtonTheme? linkButtonTheme,
    ShadBadgeTheme? primaryBadgeTheme,
    ShadBadgeTheme? secondaryBadgeTheme,
    ShadBadgeTheme? destructiveBadgeTheme,
    ShadBadgeTheme? outlineBadgeTheme,
    BorderRadius? radius,
    ShadAvatarTheme? avatarTheme,
    ShadButtonSizesTheme? buttonSizesTheme,
    ShadTooltipTheme? tooltipTheme,
    ShadPopoverTheme? popoverTheme,
    ShadDecoration? decoration,
    ShadTextTheme? textTheme,
    double? disabledOpacity,
    ShadSelectTheme? selectTheme,
    ShadOptionTheme? optionTheme,
    ShadCardTheme? cardTheme,
    ShadSwitchTheme? switchTheme,
    ShadCheckboxTheme? checkboxTheme,
    ShadInputTheme? inputTheme,
    ShadRadioTheme? radioTheme,
    ShadToastTheme? primaryToastTheme,
    ShadToastTheme? destructiveToastTheme,
    ShadBreakpoints? breakpoints,
    ShadAlertTheme? primaryAlertTheme,
    ShadAlertTheme? destructiveAlertTheme,
    ShadDialogTheme? primaryDialogTheme,
    ShadDialogTheme? alertDialogTheme,
    ShadSliderTheme? sliderTheme,
    ShadSheetTheme? sheetTheme,
    ShadProgressTheme? progressTheme,
    ShadAccordionTheme? accordionTheme,
    ShadTableTheme? tableTheme,
    ShadResizableTheme? resizableTheme,
    ShadHoverStrategies? hoverStrategies,
    bool? disableSecondaryBorder,
    ShadTabsTheme? tabsTheme,
    ShadThemeVariant? variant,
    ShadContextMenuTheme? contextMenuTheme,
    ShadCalendarTheme? calendarTheme,
    ShadDatePickerTheme? datePickerTheme,
    ShadTimePickerTheme? timePickerTheme,
    ShadInputOTPTheme? inputOTPTheme,
    ShadMenubarTheme? menubarTheme,
  }) {
    final effectiveRadius =
        radius ?? const BorderRadius.all(Radius.circular(6));

    var effectiveTextTheme =
        ShadDefaultThemeVariant.defaultTextTheme.mergeWith(textTheme);

    effectiveTextTheme = effectiveTextTheme.copyWith(
      h1Large: effectiveTextTheme.h1Large.copyWith(
        color: effectiveTextTheme.h1Large.color ?? colorScheme.foreground,
      ),
      h1: effectiveTextTheme.h1.copyWith(
        color: effectiveTextTheme.h1.color ?? colorScheme.foreground,
      ),
      h2: effectiveTextTheme.h2.copyWith(
        color: effectiveTextTheme.h2.color ?? colorScheme.foreground,
      ),
      h3: effectiveTextTheme.h3.copyWith(
        color: effectiveTextTheme.h3.color ?? colorScheme.foreground,
      ),
      h4: effectiveTextTheme.h4.copyWith(
        color: effectiveTextTheme.h4.color ?? colorScheme.foreground,
      ),
      p: effectiveTextTheme.p.copyWith(
        color: effectiveTextTheme.p.color ?? colorScheme.foreground,
      ),
      blockquote: effectiveTextTheme.blockquote.copyWith(
        color: effectiveTextTheme.blockquote.color ?? colorScheme.foreground,
      ),
      table: effectiveTextTheme.table.copyWith(
        color: effectiveTextTheme.table.color ?? colorScheme.foreground,
      ),
      list: effectiveTextTheme.list.copyWith(
        color: effectiveTextTheme.list.color ?? colorScheme.foreground,
      ),
      lead: effectiveTextTheme.lead.copyWith(
        color: effectiveTextTheme.lead.color ?? colorScheme.mutedForeground,
      ),
      large: effectiveTextTheme.large.copyWith(
        color: effectiveTextTheme.large.color ?? colorScheme.foreground,
      ),
      small: effectiveTextTheme.small.copyWith(
        color: effectiveTextTheme.small.color ?? colorScheme.foreground,
      ),
      muted: effectiveTextTheme.muted.copyWith(
        color: effectiveTextTheme.muted.color ?? colorScheme.mutedForeground,
      ),
    );

    final effectiveDisableSecondaryBorder = disableSecondaryBorder ?? false;

    final effectiveVariant = variant ??
        switch (effectiveDisableSecondaryBorder) {
          false => ShadDefaultThemeVariant(
              colorScheme: colorScheme,
              radius: effectiveRadius,
              effectiveTextTheme: effectiveTextTheme,
            ),
          true => ShadDefaultThemeNoSecondaryBorderVariant(
              colorScheme: colorScheme,
              radius: effectiveRadius,
              effectiveTextTheme: effectiveTextTheme,
            ),
        };

    return ShadThemeData._internal(
      colorScheme: colorScheme,
      brightness: brightness,
      extensions: extensions,
      primaryButtonTheme:
          effectiveVariant.primaryButtonTheme().mergeWith(primaryButtonTheme),
      secondaryButtonTheme: effectiveVariant
          .secondaryButtonTheme()
          .mergeWith(secondaryButtonTheme),
      destructiveButtonTheme: effectiveVariant
          .destructiveButtonTheme()
          .mergeWith(destructiveButtonTheme),
      outlineButtonTheme:
          effectiveVariant.outlineButtonTheme().mergeWith(outlineButtonTheme),
      ghostButtonTheme:
          effectiveVariant.ghostButtonTheme().mergeWith(ghostButtonTheme),
      linkButtonTheme:
          effectiveVariant.linkButtonTheme().mergeWith(linkButtonTheme),
      primaryBadgeTheme:
          effectiveVariant.primaryBadgeTheme().mergeWith(primaryBadgeTheme),
      secondaryBadgeTheme:
          effectiveVariant.secondaryBadgeTheme().mergeWith(secondaryBadgeTheme),
      destructiveBadgeTheme: effectiveVariant
          .destructiveBadgeTheme()
          .mergeWith(destructiveBadgeTheme),
      outlineBadgeTheme:
          effectiveVariant.outlineBadgeTheme().mergeWith(outlineBadgeTheme),
      buttonSizesTheme:
          effectiveVariant.buttonSizesTheme().mergeWith(buttonSizesTheme),
      radius: effectiveRadius,
      avatarTheme: effectiveVariant.avatarTheme().mergeWith(avatarTheme),
      tooltipTheme: effectiveVariant.tooltipTheme().mergeWith(tooltipTheme),
      popoverTheme: effectiveVariant.popoverTheme().mergeWith(popoverTheme),
      decoration: effectiveVariant.decorationTheme().mergeWith(decoration),
      textTheme: effectiveTextTheme,
      disabledOpacity: disabledOpacity ?? .5,
      selectTheme: effectiveVariant.selectTheme().mergeWith(selectTheme),
      optionTheme: effectiveVariant.optionTheme().mergeWith(optionTheme),
      cardTheme: effectiveVariant.cardTheme().mergeWith(cardTheme),
      switchTheme: effectiveVariant.switchTheme().mergeWith(switchTheme),
      checkboxTheme: effectiveVariant.checkboxTheme().mergeWith(checkboxTheme),
      inputTheme: effectiveVariant.inputTheme().mergeWith(inputTheme),
      radioTheme: effectiveVariant.radioTheme().mergeWith(radioTheme),
      primaryToastTheme:
          effectiveVariant.primaryToastTheme().mergeWith(primaryToastTheme),
      destructiveToastTheme: effectiveVariant
          .destructiveToastTheme()
          .mergeWith(destructiveToastTheme),
      breakpoints: breakpoints ?? ShadBreakpoints(),
      primaryAlertTheme:
          effectiveVariant.primaryAlertTheme().mergeWith(primaryAlertTheme),
      destructiveAlertTheme: effectiveVariant
          .destructiveAlertTheme()
          .mergeWith(destructiveAlertTheme),
      primaryDialogTheme:
          effectiveVariant.primaryDialogTheme().mergeWith(primaryDialogTheme),
      alertDialogTheme:
          effectiveVariant.alertDialogTheme().mergeWith(alertDialogTheme),
      sliderTheme: effectiveVariant.sliderTheme().mergeWith(sliderTheme),
      sheetTheme: effectiveVariant.sheetTheme().mergeWith(sheetTheme),
      progressTheme: effectiveVariant.progressTheme().mergeWith(progressTheme),
      accordionTheme:
          effectiveVariant.accordionTheme().mergeWith(accordionTheme),
      tableTheme: effectiveVariant.tableTheme().mergeWith(tableTheme),
      resizableTheme:
          effectiveVariant.resizableTheme().mergeWith(resizableTheme),
      hoverStrategies: hoverStrategies ?? effectiveVariant.hoverStrategies(),
      disableSecondaryBorder: effectiveDisableSecondaryBorder,
      tabsTheme: effectiveVariant.tabsTheme().mergeWith(tabsTheme),
      contextMenuTheme:
          effectiveVariant.contextMenuTheme().mergeWith(contextMenuTheme),
      calendarTheme: effectiveVariant.calendarTheme().mergeWith(calendarTheme),
      datePickerTheme:
          effectiveVariant.datePickerTheme().mergeWith(datePickerTheme),
      timePickerTheme:
          effectiveVariant.timePickerTheme().mergeWith(timePickerTheme),
      inputOTPTheme: effectiveVariant.inputOTPTheme().mergeWith(inputOTPTheme),
      menubarTheme: effectiveVariant.menubarTheme().mergeWith(menubarTheme),
    );
  }

  const ShadThemeData._internal({
    required super.colorScheme,
    required super.brightness,
    required super.extensions,
    required super.primaryButtonTheme,
    required super.secondaryButtonTheme,
    required super.destructiveButtonTheme,
    required super.outlineButtonTheme,
    required super.ghostButtonTheme,
    required super.linkButtonTheme,
    required super.primaryBadgeTheme,
    required super.secondaryBadgeTheme,
    required super.destructiveBadgeTheme,
    required super.outlineBadgeTheme,
    required super.radius,
    required super.avatarTheme,
    required super.buttonSizesTheme,
    required super.tooltipTheme,
    required super.popoverTheme,
    required super.decoration,
    required super.textTheme,
    required super.disabledOpacity,
    required super.selectTheme,
    required super.optionTheme,
    required super.cardTheme,
    required super.switchTheme,
    required super.checkboxTheme,
    required super.inputTheme,
    required super.radioTheme,
    required super.primaryToastTheme,
    required super.destructiveToastTheme,
    required super.breakpoints,
    required super.primaryAlertTheme,
    required super.destructiveAlertTheme,
    required super.primaryDialogTheme,
    required super.alertDialogTheme,
    required super.sliderTheme,
    required super.sheetTheme,
    required super.progressTheme,
    required super.accordionTheme,
    required super.tableTheme,
    required super.resizableTheme,
    required super.hoverStrategies,
    required super.disableSecondaryBorder,
    required super.tabsTheme,
    required super.contextMenuTheme,
    required super.calendarTheme,
    required super.datePickerTheme,
    required super.timePickerTheme,
    required super.inputOTPTheme,
    required super.menubarTheme,
  });

  static ShadThemeData lerp(ShadThemeData a, ShadThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return ShadThemeData(
      colorScheme: ShadColorScheme.lerp(a.colorScheme, b.colorScheme, t),
      brightness: b.brightness,
      primaryButtonTheme:
          ShadButtonTheme.lerp(a.primaryButtonTheme, b.primaryButtonTheme, t),
      secondaryButtonTheme: ShadButtonTheme.lerp(
        a.secondaryButtonTheme,
        b.secondaryButtonTheme,
        t,
      ),
      destructiveButtonTheme: ShadButtonTheme.lerp(
        a.destructiveButtonTheme,
        b.destructiveButtonTheme,
        t,
      ),
      outlineButtonTheme:
          ShadButtonTheme.lerp(a.outlineButtonTheme, b.outlineButtonTheme, t),
      ghostButtonTheme:
          ShadButtonTheme.lerp(a.ghostButtonTheme, b.ghostButtonTheme, t),
      linkButtonTheme:
          ShadButtonTheme.lerp(a.linkButtonTheme, b.linkButtonTheme, t),
      primaryBadgeTheme:
          ShadBadgeTheme.lerp(a.primaryBadgeTheme, b.primaryBadgeTheme, t),
      secondaryBadgeTheme: ShadBadgeTheme.lerp(
        a.secondaryBadgeTheme,
        b.secondaryBadgeTheme,
        t,
      ),
      destructiveBadgeTheme: ShadBadgeTheme.lerp(
        a.destructiveBadgeTheme,
        b.destructiveBadgeTheme,
        t,
      ),
      outlineBadgeTheme:
          ShadBadgeTheme.lerp(a.outlineBadgeTheme, b.outlineBadgeTheme, t),
      radius: BorderRadius.lerp(a.radius, b.radius, t),
      avatarTheme: ShadAvatarTheme.lerp(a.avatarTheme, b.avatarTheme, t),
      buttonSizesTheme: ShadButtonSizesTheme.lerp(
        a.buttonSizesTheme,
        b.buttonSizesTheme,
        t,
      ),
      tooltipTheme: ShadTooltipTheme.lerp(a.tooltipTheme, b.tooltipTheme, t),
      popoverTheme: ShadPopoverTheme.lerp(a.popoverTheme, b.popoverTheme, t),
      decoration: ShadDecoration.lerp(a.decoration, b.decoration, t),
      textTheme: ShadTextTheme.lerp(a.textTheme, b.textTheme, t),
      disabledOpacity: lerpDouble(a.disabledOpacity, b.disabledOpacity, t),
      selectTheme: ShadSelectTheme.lerp(a.selectTheme, b.selectTheme, t),
      optionTheme: ShadOptionTheme.lerp(a.optionTheme, b.optionTheme, t),
      cardTheme: ShadCardTheme.lerp(a.cardTheme, b.cardTheme, t),
      switchTheme: ShadSwitchTheme.lerp(a.switchTheme, b.switchTheme, t),
      checkboxTheme:
          ShadCheckboxTheme.lerp(a.checkboxTheme, b.checkboxTheme, t),
      inputTheme: ShadInputTheme.lerp(a.inputTheme, b.inputTheme, t),
      radioTheme: ShadRadioTheme.lerp(a.radioTheme, b.radioTheme, t),
      primaryToastTheme:
          ShadToastTheme.lerp(a.primaryToastTheme, b.primaryToastTheme, t),
      destructiveToastTheme: ShadToastTheme.lerp(
        a.destructiveToastTheme,
        b.destructiveToastTheme,
        t,
      ),
      breakpoints: ShadBreakpoints.lerp(a.breakpoints, b.breakpoints, t),
      primaryAlertTheme:
          ShadAlertTheme.lerp(a.primaryAlertTheme, b.primaryAlertTheme, t),
      destructiveAlertTheme: ShadAlertTheme.lerp(
        a.destructiveAlertTheme,
        b.destructiveAlertTheme,
        t,
      ),
      primaryDialogTheme:
          ShadDialogTheme.lerp(a.primaryDialogTheme, b.primaryDialogTheme, t),
      alertDialogTheme:
          ShadDialogTheme.lerp(a.alertDialogTheme, b.alertDialogTheme, t),
      sliderTheme: ShadSliderTheme.lerp(a.sliderTheme, b.sliderTheme, t),
      progressTheme:
          ShadProgressTheme.lerp(a.progressTheme, b.progressTheme, t),
      accordionTheme:
          ShadAccordionTheme.lerp(a.accordionTheme, b.accordionTheme, t),
      tableTheme: ShadTableTheme.lerp(a.tableTheme, b.tableTheme, t),
      resizableTheme:
          ShadResizableTheme.lerp(a.resizableTheme, b.resizableTheme, t),
      hoverStrategies: t < .5 ? a.hoverStrategies : b.hoverStrategies,
      disableSecondaryBorder:
          t < .5 ? a.disableSecondaryBorder : b.disableSecondaryBorder,
      tabsTheme: ShadTabsTheme.lerp(a.tabsTheme, b.tabsTheme, t),
      contextMenuTheme:
          ShadContextMenuTheme.lerp(a.contextMenuTheme, b.contextMenuTheme, t),
      calendarTheme:
          ShadCalendarTheme.lerp(a.calendarTheme, b.calendarTheme, t),
      datePickerTheme:
          ShadDatePickerTheme.lerp(a.datePickerTheme, b.datePickerTheme, t),
      timePickerTheme:
          ShadTimePickerTheme.lerp(a.timePickerTheme, b.timePickerTheme, t),
      inputOTPTheme:
          ShadInputOTPTheme.lerp(a.inputOTPTheme, b.inputOTPTheme, t),
      menubarTheme: ShadMenubarTheme.lerp(a.menubarTheme, b.menubarTheme, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShadBaseTheme &&
        other.colorScheme == colorScheme &&
        other.brightness == brightness &&
        other.primaryButtonTheme == primaryButtonTheme &&
        other.secondaryButtonTheme == secondaryButtonTheme &&
        other.destructiveButtonTheme == destructiveButtonTheme &&
        other.outlineButtonTheme == outlineButtonTheme &&
        other.ghostButtonTheme == ghostButtonTheme &&
        other.linkButtonTheme == linkButtonTheme &&
        other.primaryBadgeTheme == primaryBadgeTheme &&
        other.secondaryBadgeTheme == secondaryBadgeTheme &&
        other.destructiveBadgeTheme == destructiveBadgeTheme &&
        other.outlineBadgeTheme == outlineBadgeTheme &&
        other.radius == radius &&
        other.avatarTheme == avatarTheme &&
        other.buttonSizesTheme == buttonSizesTheme &&
        other.tooltipTheme == tooltipTheme &&
        other.popoverTheme == popoverTheme &&
        other.decoration == decoration &&
        other.textTheme == textTheme &&
        other.disabledOpacity == disabledOpacity &&
        other.selectTheme == selectTheme &&
        other.optionTheme == optionTheme &&
        other.cardTheme == cardTheme &&
        other.optionTheme == optionTheme &&
        other.switchTheme == switchTheme &&
        other.checkboxTheme == checkboxTheme &&
        other.inputTheme == inputTheme &&
        other.radioTheme == radioTheme &&
        other.primaryToastTheme == primaryToastTheme &&
        other.destructiveToastTheme == destructiveToastTheme &&
        other.breakpoints == breakpoints &&
        other.primaryAlertTheme == primaryAlertTheme &&
        other.destructiveAlertTheme == destructiveAlertTheme &&
        other.primaryDialogTheme == primaryDialogTheme &&
        other.alertDialogTheme == alertDialogTheme &&
        other.sliderTheme == sliderTheme &&
        other.sheetTheme == sheetTheme &&
        other.progressTheme == progressTheme &&
        other.accordionTheme == accordionTheme &&
        other.tableTheme == tableTheme &&
        other.resizableTheme == resizableTheme &&
        other.hoverStrategies == hoverStrategies &&
        other.disableSecondaryBorder == disableSecondaryBorder &&
        other.tabsTheme == tabsTheme &&
        other.contextMenuTheme == contextMenuTheme &&
        other.calendarTheme == calendarTheme &&
        other.datePickerTheme == datePickerTheme &&
        other.timePickerTheme == timePickerTheme &&
        other.inputOTPTheme == inputOTPTheme &&
        other.menubarTheme == menubarTheme;
  }

  @override
  int get hashCode {
    return colorScheme.hashCode ^
        brightness.hashCode ^
        primaryButtonTheme.hashCode ^
        secondaryButtonTheme.hashCode ^
        destructiveButtonTheme.hashCode ^
        outlineButtonTheme.hashCode ^
        ghostButtonTheme.hashCode ^
        linkButtonTheme.hashCode ^
        primaryBadgeTheme.hashCode ^
        secondaryBadgeTheme.hashCode ^
        outlineBadgeTheme.hashCode ^
        destructiveBadgeTheme.hashCode ^
        radius.hashCode ^
        avatarTheme.hashCode ^
        buttonSizesTheme.hashCode ^
        tooltipTheme.hashCode ^
        popoverTheme.hashCode ^
        decoration.hashCode ^
        textTheme.hashCode ^
        disabledOpacity.hashCode ^
        selectTheme.hashCode ^
        optionTheme.hashCode ^
        cardTheme.hashCode ^
        optionTheme.hashCode ^
        switchTheme.hashCode ^
        checkboxTheme.hashCode ^
        inputTheme.hashCode ^
        radioTheme.hashCode ^
        primaryToastTheme.hashCode ^
        destructiveToastTheme.hashCode ^
        breakpoints.hashCode ^
        primaryAlertTheme.hashCode ^
        destructiveAlertTheme.hashCode ^
        primaryDialogTheme.hashCode ^
        alertDialogTheme.hashCode ^
        sliderTheme.hashCode ^
        sheetTheme.hashCode ^
        progressTheme.hashCode ^
        accordionTheme.hashCode ^
        tableTheme.hashCode ^
        resizableTheme.hashCode ^
        hoverStrategies.hashCode ^
        disableSecondaryBorder.hashCode ^
        tabsTheme.hashCode ^
        contextMenuTheme.hashCode ^
        calendarTheme.hashCode ^
        datePickerTheme.hashCode ^
        timePickerTheme.hashCode ^
        inputOTPTheme.hashCode ^
        menubarTheme.hashCode;
  }

  ShadThemeData copyWith({
    ShadColorScheme? colorScheme,
    ShadButtonTheme? primaryButtonTheme,
    ShadButtonTheme? secondaryButtonTheme,
    ShadButtonTheme? destructiveButtonTheme,
    ShadButtonTheme? outlineButtonTheme,
    ShadButtonTheme? ghostButtonTheme,
    ShadButtonTheme? linkButtonTheme,
    ShadBadgeTheme? primaryBadgeTheme,
    ShadBadgeTheme? secondaryBadgeTheme,
    ShadBadgeTheme? destructiveBadgeTheme,
    ShadBadgeTheme? outlineBadgeTheme,
    Brightness? brightness,
    Iterable<ThemeExtension<dynamic>>? extensions,
    BorderRadius? radius,
    ShadAvatarTheme? avatarTheme,
    ShadButtonSizesTheme? buttonSizesTheme,
    ShadTooltipTheme? tooltipTheme,
    ShadPopoverTheme? popoverTheme,
    ShadDecoration? decoration,
    ShadTextTheme? textTheme,
    double? disabledOpacity,
    ShadSelectTheme? selectTheme,
    ShadOptionTheme? optionTheme,
    ShadCardTheme? cardTheme,
    ShadSwitchTheme? switchTheme,
    ShadCheckboxTheme? checkboxTheme,
    ShadInputTheme? inputTheme,
    ShadRadioTheme? radioTheme,
    ShadToastTheme? primaryToastTheme,
    ShadToastTheme? destructiveToastTheme,
    ShadBreakpoints? breakpoints,
    ShadAlertTheme? primaryAlertTheme,
    ShadAlertTheme? destructiveAlertTheme,
    ShadDialogTheme? primaryDialogTheme,
    ShadDialogTheme? alertDialogTheme,
    ShadSliderTheme? sliderTheme,
    ShadSheetTheme? sheetTheme,
    ShadProgressTheme? progressTheme,
    ShadAccordionTheme? accordionTheme,
    ShadTableTheme? tableTheme,
    ShadResizableTheme? resizableTheme,
    ShadHoverStrategies? hoverStrategies,
    bool? disableSecondaryBorder,
    ShadTabsTheme? tabsTheme,
    ShadContextMenuTheme? contextMenuTheme,
    ShadCalendarTheme? calendarTheme,
    ShadDatePickerTheme? datePickerTheme,
    ShadTimePickerTheme? timePickerTheme,
    ShadInputOTPTheme? inputOTPTheme,
    ShadMenubarTheme? menubarTheme,
  }) {
    return ShadThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      extensions: extensions ?? this.extensions,
      brightness: brightness ?? this.brightness,
      primaryButtonTheme: primaryButtonTheme ?? this.primaryButtonTheme,
      secondaryButtonTheme: secondaryButtonTheme ?? this.secondaryButtonTheme,
      destructiveButtonTheme:
          destructiveButtonTheme ?? this.destructiveButtonTheme,
      outlineButtonTheme: outlineButtonTheme ?? this.outlineButtonTheme,
      ghostButtonTheme: ghostButtonTheme ?? this.ghostButtonTheme,
      linkButtonTheme: linkButtonTheme ?? this.linkButtonTheme,
      primaryBadgeTheme: primaryBadgeTheme ?? this.primaryBadgeTheme,
      secondaryBadgeTheme: secondaryBadgeTheme ?? this.secondaryBadgeTheme,
      destructiveBadgeTheme:
          destructiveBadgeTheme ?? this.destructiveBadgeTheme,
      outlineBadgeTheme: outlineBadgeTheme ?? this.outlineBadgeTheme,
      radius: radius ?? this.radius,
      avatarTheme: avatarTheme ?? this.avatarTheme,
      buttonSizesTheme: buttonSizesTheme ?? this.buttonSizesTheme,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
      popoverTheme: popoverTheme ?? this.popoverTheme,
      decoration: decoration ?? this.decoration,
      textTheme: textTheme ?? this.textTheme,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      selectTheme: selectTheme ?? this.selectTheme,
      optionTheme: optionTheme ?? this.optionTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      switchTheme: switchTheme ?? this.switchTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      inputTheme: inputTheme ?? this.inputTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      primaryToastTheme: primaryToastTheme ?? this.primaryToastTheme,
      destructiveToastTheme:
          destructiveToastTheme ?? this.destructiveToastTheme,
      breakpoints: breakpoints ?? this.breakpoints,
      primaryAlertTheme: primaryAlertTheme ?? this.primaryAlertTheme,
      destructiveAlertTheme:
          destructiveAlertTheme ?? this.destructiveAlertTheme,
      primaryDialogTheme: primaryDialogTheme ?? this.primaryDialogTheme,
      alertDialogTheme: alertDialogTheme ?? this.alertDialogTheme,
      sliderTheme: sliderTheme ?? this.sliderTheme,
      sheetTheme: sheetTheme ?? this.sheetTheme,
      progressTheme: progressTheme ?? this.progressTheme,
      accordionTheme: accordionTheme ?? this.accordionTheme,
      tableTheme: tableTheme ?? this.tableTheme,
      resizableTheme: resizableTheme ?? this.resizableTheme,
      hoverStrategies: hoverStrategies ?? this.hoverStrategies,
      disableSecondaryBorder:
          disableSecondaryBorder ?? this.disableSecondaryBorder,
      tabsTheme: tabsTheme ?? this.tabsTheme,
      contextMenuTheme: contextMenuTheme ?? this.contextMenuTheme,
      calendarTheme: calendarTheme ?? this.calendarTheme,
      datePickerTheme: datePickerTheme ?? this.datePickerTheme,
      timePickerTheme: timePickerTheme ?? this.timePickerTheme,
      inputOTPTheme: inputOTPTheme ?? this.inputOTPTheme,
      menubarTheme: menubarTheme ?? this.menubarTheme,
    );
  }
}
