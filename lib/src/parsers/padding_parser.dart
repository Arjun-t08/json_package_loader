import 'package:flutter/widgets.dart';
import '../parser.dart';

/// A parser for the [Padding] widget.
/// Expected JSON:
/// {
///   "type": "Padding",
///   "padding": {"left": 10, "top": 10, "right": 10, "bottom": 10},
///   "child": { ... }
/// }
class PaddingParser extends BaseWidgetParser {
  @override
  String get type => 'Padding';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final paddingMap = json['padding'] as Map<String, dynamic>?;
    final childJson = json['child'] as Map<String, dynamic>?;

    EdgeInsets padding = EdgeInsets.zero;
    if (paddingMap != null) {
      padding = EdgeInsets.fromLTRB(
        (paddingMap['left'] as num? ?? 0).toDouble(),
        (paddingMap['top'] as num? ?? 0).toDouble(),
        (paddingMap['right'] as num? ?? 0).toDouble(),
        (paddingMap['bottom'] as num? ?? 0).toDouble(),
      );
    }

    return Padding(
      padding: padding,
      child: childJson != null ? generator.build(childJson) : null,
    );
  }
}
