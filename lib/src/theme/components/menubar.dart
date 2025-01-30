import 'package:flutter/widgets.dart';

@immutable
class ShadMenubarTheme {
  const ShadMenubarTheme({
    this.merge = true,
  });

  final bool merge;

  static ShadMenubarTheme lerp(
    ShadMenubarTheme a,
    ShadMenubarTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return ShadMenubarTheme(
      merge: b.merge,
    );
  }

  ShadMenubarTheme copyWith({
    bool? merge,
  }) {
    return ShadMenubarTheme(
      merge: merge ?? this.merge,
    );
  }

  ShadMenubarTheme mergeWith(ShadMenubarTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShadMenubarTheme && other.merge == merge;
  }

  @override
  int get hashCode {
    return merge.hashCode;
  }
}
