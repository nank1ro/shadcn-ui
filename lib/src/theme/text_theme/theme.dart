import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:shadcn_ui/src/theme/text_theme/text_styles_default.dart';
import 'package:shadcn_ui/src/theme/themes/default_theme_variant.dart';

extension on TextStyle {
  TextStyle get omitFamilyAndPackage {
    return TextStyle(
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      leadingDistribution: leadingDistribution,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      fontVariations: fontVariations,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      fontFamilyFallback: fontFamilyFallback,
      overflow: overflow,
    );
  }
}

typedef GoogleFontBuilder = TextStyle Function({
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<ui.Shadow>? shadows,
  List<ui.FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
});

// Workaround for google fonts, see https://github.com/material-foundation/flutter-packages/issues/35
class GoogleFontTextStyle extends TextStyle {
  GoogleFontTextStyle(
    TextStyle textStyle, {
    required this.builder,
    this.overrideFamilyWithBuilder = false,
  }) : super(
          inherit: textStyle.inherit,
          color: textStyle.color,
          backgroundColor: textStyle.backgroundColor,
          fontSize: textStyle.fontSize,
          fontWeight: textStyle.fontWeight,
          fontStyle: textStyle.fontStyle,
          letterSpacing: textStyle.letterSpacing,
          wordSpacing: textStyle.wordSpacing,
          textBaseline: textStyle.textBaseline,
          height: textStyle.height,
          leadingDistribution: textStyle.leadingDistribution,
          locale: textStyle.locale,
          foreground: textStyle.foreground,
          background: textStyle.background,
          shadows: textStyle.shadows,
          fontFeatures: textStyle.fontFeatures,
          fontVariations: textStyle.fontVariations,
          decoration: textStyle.decoration,
          decorationColor: textStyle.decorationColor,
          decorationStyle: textStyle.decorationStyle,
          decorationThickness: textStyle.decorationThickness,
          debugLabel: textStyle.debugLabel,
          fontFamily: overrideFamilyWithBuilder
              ? builder(
                  fontWeight: textStyle.fontWeight,
                  fontStyle: textStyle.fontStyle,
                ).fontFamily
              : textStyle.fontFamily ??
                  ((textStyle.fontWeight != null || textStyle.fontStyle != null)
                      ? builder(
                          fontWeight: textStyle.fontWeight,
                          fontStyle: textStyle.fontStyle,
                        ).fontFamily
                      : null),
          fontFamilyFallback: textStyle.fontFamilyFallback,
          overflow: textStyle.overflow,
        );

  final GoogleFontBuilder builder;
  final bool overrideFamilyWithBuilder;

  @override
  TextStyle copyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    List<ui.FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    var family = fontFamily ??
        ((fontWeight != null || fontStyle != null)
            ? builder(fontWeight: fontWeight, fontStyle: fontStyle).fontFamily
            : null);
    if (overrideFamilyWithBuilder) {
      family = builder(
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ).fontFamily;
    }
    return super.copyWith(
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      leadingDistribution: leadingDistribution,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      fontVariations: fontVariations,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      fontFamily: family,
      fontFamilyFallback: fontFamilyFallback,
      package: package,
      overflow: overflow,
    );
  }
}

@immutable
class ShadTextTheme {
  factory ShadTextTheme({
    TextStyle? h1Large,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? p,
    TextStyle? blockquote,
    TextStyle? table,
    TextStyle? list,
    TextStyle? lead,
    TextStyle? large,
    TextStyle? small,
    TextStyle? muted,
    String? family,
    String? package,
    GoogleFontBuilder? googleFontBuilder,
  }) {
    var effectiveFamily = family ?? kDefaultFontFamily;
    if (package != null && package != '') {
      effectiveFamily = 'packages/$package/$effectiveFamily';
    }

    return ShadTextTheme.custom(
      h1Large: h1Large ?? ShadTextDefaultTheme.h1Large(family: effectiveFamily),
      h1: h1 ?? ShadTextDefaultTheme.h1(family: effectiveFamily),
      h2: h2 ?? ShadTextDefaultTheme.h2(family: effectiveFamily),
      h3: h3 ?? ShadTextDefaultTheme.h3(family: effectiveFamily),
      h4: h4 ?? ShadTextDefaultTheme.h4(family: effectiveFamily),
      p: p ?? ShadTextDefaultTheme.p(family: effectiveFamily),
      blockquote: blockquote ??
          ShadTextDefaultTheme.blockquote(family: effectiveFamily),
      table: table ?? ShadTextDefaultTheme.table(family: effectiveFamily),
      list: list ?? ShadTextDefaultTheme.list(family: effectiveFamily),
      lead: lead ?? ShadTextDefaultTheme.lead(family: effectiveFamily),
      large: large ?? ShadTextDefaultTheme.large(family: effectiveFamily),
      small: small ?? ShadTextDefaultTheme.small(family: effectiveFamily),
      muted: muted ?? ShadTextDefaultTheme.muted(family: effectiveFamily),
      family: effectiveFamily,
      googleFontBuilder: googleFontBuilder,
    );
  }

  const ShadTextTheme.custom({
    this.merge = true,
    required this.h1Large,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.p,
    required this.blockquote,
    required this.table,
    required this.list,
    required this.lead,
    required this.large,
    required this.small,
    required this.muted,
    required this.family,
    this.googleFontBuilder,
  });

  factory ShadTextTheme.fromGoogleFont(
    GoogleFontBuilder fontBuilder, {
    ShadTextTheme? textTheme,
  }) {
    final effectiveTextTheme =
        textTheme ?? ShadDefaultThemeVariant.defaultTextTheme;

    final p = GoogleFontTextStyle(
      effectiveTextTheme.p.omitFamilyAndPackage,
      builder: fontBuilder,
    );

    return ShadTextTheme(
      h1Large: GoogleFontTextStyle(
        effectiveTextTheme.h1Large.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      h1: GoogleFontTextStyle(
        effectiveTextTheme.h1.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      h2: GoogleFontTextStyle(
        effectiveTextTheme.h2.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      h3: GoogleFontTextStyle(
        effectiveTextTheme.h3.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      h4: GoogleFontTextStyle(
        effectiveTextTheme.h4.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      p: p,
      blockquote: GoogleFontTextStyle(
        effectiveTextTheme.blockquote.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      table: GoogleFontTextStyle(
        effectiveTextTheme.table.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      list: GoogleFontTextStyle(
        effectiveTextTheme.list.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      lead: GoogleFontTextStyle(
        effectiveTextTheme.lead.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      large: GoogleFontTextStyle(
        effectiveTextTheme.large.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      small: GoogleFontTextStyle(
        effectiveTextTheme.small.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      muted: GoogleFontTextStyle(
        effectiveTextTheme.muted.omitFamilyAndPackage,
        builder: fontBuilder,
      ),
      family: p.fontFamily,
      googleFontBuilder: fontBuilder,
    );
  }

  TextTheme applyGoogleFontToTextTheme(TextTheme textTheme) {
    if (googleFontBuilder == null) return textTheme;
    return TextTheme(
      displayLarge: GoogleFontTextStyle(
        (textTheme.displayLarge ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      displayMedium: GoogleFontTextStyle(
        (textTheme.displayMedium ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      displaySmall: GoogleFontTextStyle(
        (textTheme.displaySmall ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      headlineLarge: GoogleFontTextStyle(
        (textTheme.headlineLarge ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      headlineMedium: GoogleFontTextStyle(
        (textTheme.headlineMedium ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      headlineSmall: GoogleFontTextStyle(
        (textTheme.headlineSmall ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      titleLarge: GoogleFontTextStyle(
        (textTheme.titleLarge ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      titleMedium: GoogleFontTextStyle(
        (textTheme.titleMedium ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      titleSmall: GoogleFontTextStyle(
        (textTheme.titleSmall ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      bodyLarge: GoogleFontTextStyle(
        (textTheme.bodyLarge ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      bodyMedium: GoogleFontTextStyle(
        (textTheme.bodyMedium ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      bodySmall: GoogleFontTextStyle(
        (textTheme.bodySmall ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      labelLarge: GoogleFontTextStyle(
        (textTheme.labelLarge ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      labelMedium: GoogleFontTextStyle(
        (textTheme.labelMedium ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
      labelSmall: GoogleFontTextStyle(
        (textTheme.labelSmall ?? const TextStyle()).omitFamilyAndPackage,
        builder: googleFontBuilder!,
        overrideFamilyWithBuilder: true,
      ),
    );
  }

  final TextStyle h1Large;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle p;
  final TextStyle blockquote;
  final TextStyle table;
  final TextStyle list;
  final TextStyle lead;
  final TextStyle large;
  final TextStyle small;
  final TextStyle muted;

  /// The font family of the theme.
  final String family;

  final bool merge;

  final GoogleFontBuilder? googleFontBuilder;

  ShadTextTheme copyWith({
    TextStyle? h1Large,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? p,
    TextStyle? blockquote,
    TextStyle? table,
    TextStyle? list,
    TextStyle? lead,
    TextStyle? large,
    TextStyle? small,
    TextStyle? muted,
    String? family,
    String? package,
    GoogleFontBuilder? googleFontBuilder,
  }) {
    var effectiveFamily = family ?? kDefaultFontFamily;
    if (package != null && package != '') {
      effectiveFamily = 'packages/$package/$effectiveFamily';
    }

    return ShadTextTheme.custom(
      merge: merge,
      h1Large: h1Large ?? this.h1Large,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      p: p ?? this.p,
      blockquote: blockquote ?? this.blockquote,
      table: table ?? this.table,
      list: list ?? this.list,
      lead: lead ?? this.lead,
      large: large ?? this.large,
      small: small ?? this.small,
      muted: muted ?? this.muted,
      family: effectiveFamily,
      googleFontBuilder: googleFontBuilder ?? this.googleFontBuilder,
    );
  }

  ShadTextTheme mergeWith(ShadTextTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;

    return copyWith(
      h1Large: h1Large.merge(other.h1Large),
      h1: h1.merge(other.h1),
      h2: h2.merge(other.h2),
      h3: h3.merge(other.h3),
      h4: h4.merge(other.h4),
      p: p.merge(other.p),
      blockquote: blockquote.merge(other.blockquote),
      table: table.merge(other.table),
      list: list.merge(other.list),
      lead: lead.merge(other.lead),
      large: large.merge(other.large),
      small: small.merge(other.small),
      muted: muted.merge(other.muted),
      family: other.family,
      googleFontBuilder: other.googleFontBuilder,
    );
  }

  ShadTextTheme apply({
    String? family,
    List<String>? fontFamilyFallback,
    String? package,
    double fontSizeFactor = 1.0,
    double fontSizeDelta = 0.0,
    Color? displayColor,
    Color? bodyColor,
    Color? decorationColor,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    final effectiveFamily = family ?? this.family;
    return ShadTextTheme.custom(
      merge: merge,
      family: effectiveFamily,
      h1Large: h1Large.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      h1: h1.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      h2: h2.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      h3: h3.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      h4: h4.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      p: p.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      blockquote: blockquote.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      table: table.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      list: list.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      lead: lead.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      large: large.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        color: bodyColor,
      ),
      small: small.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        color: bodyColor,
      ),
      muted: muted.apply(
        fontFamily: effectiveFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      googleFontBuilder: googleFontBuilder,
    );
  }

  static ShadTextTheme lerp(
    ShadTextTheme? a,
    ShadTextTheme? b,
    double t,
  ) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return ShadTextTheme.custom(
      h1Large: TextStyle.lerp(a!.h1Large, b!.h1Large, t)!,
      h1: TextStyle.lerp(a.h1, b.h1, t)!,
      h2: TextStyle.lerp(a.h2, b.h2, t)!,
      h3: TextStyle.lerp(a.h3, b.h3, t)!,
      h4: TextStyle.lerp(a.h4, b.h4, t)!,
      p: TextStyle.lerp(a.p, b.p, t)!,
      blockquote: TextStyle.lerp(a.blockquote, b.blockquote, t)!,
      table: TextStyle.lerp(a.table, b.table, t)!,
      list: TextStyle.lerp(a.list, b.list, t)!,
      lead: TextStyle.lerp(a.lead, b.lead, t)!,
      large: TextStyle.lerp(a.large, b.large, t)!,
      small: TextStyle.lerp(a.small, b.small, t)!,
      muted: TextStyle.lerp(a.muted, b.muted, t)!,
      family: t < 0.5 ? a.family : b.family,
      googleFontBuilder: t < 0.5 ? a.googleFontBuilder : b.googleFontBuilder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ShadTextTheme &&
        other.h1Large == h1Large &&
        other.h1 == h1 &&
        other.h2 == h2 &&
        other.h3 == h3 &&
        other.h4 == h4 &&
        other.p == p &&
        other.blockquote == blockquote &&
        other.table == table &&
        other.list == list &&
        other.lead == lead &&
        other.large == large &&
        other.small == small &&
        other.muted == muted &&
        other.family == family &&
        other.googleFontBuilder == googleFontBuilder;
  }

  @override
  int get hashCode {
    return Object.hash(
      h1Large,
      h1,
      h2,
      h3,
      h4,
      p,
      blockquote,
      table,
      list,
      lead,
      large,
      small,
      muted,
      family,
      merge,
      googleFontBuilder,
    );
  }
}
