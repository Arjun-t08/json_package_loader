import 'package:flutter/widgets.dart';
import '../parser.dart';

/// A parser for the [Container] widget.
/// Expected JSON:
/// {
///   "type": "Container",
///   "padding": {"left": 10, "top": 10, "right": 10, "bottom": 10},
///   "color": "0xFFE0E0E0",
///   "child": { ... }, // Optional single child
///   "children": [ { ... }, { ... } ] // Optional multiple children (represented as a Column in this simple example)
/// }
class ContainerParser extends BaseWidgetParser {
  @override
  String get type => 'Container';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final paddingMap = json['padding'] as Map<String, dynamic>?;
    final colorHex = json['color'] as String?;
    final childJson = json['child'] as Map<String, dynamic>?;
    final childrenJson = json['children'] as List<dynamic>?;

    EdgeInsets? padding;
    if (paddingMap != null) {
      padding = EdgeInsets.fromLTRB(
        (paddingMap['left'] as num? ?? 0).toDouble(),
        (paddingMap['top'] as num? ?? 0).toDouble(),
        (paddingMap['right'] as num? ?? 0).toDouble(),
        (paddingMap['bottom'] as num? ?? 0).toDouble(),
      );
    }

    Color? color;
    if (colorHex != null) {
      try {
        color = Color(int.parse(colorHex));
      } catch (e) {
        debugPrint('Invalid color hex: $colorHex');
      }
    }

    Widget? child;
    if (childJson != null) {
      child = generator.build(childJson);
    } else if (childrenJson != null) {
      // In a real system, you might have Row/Column parsers,
      // but here we demonstrate recursion by wrapping children in a Column.
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: childrenJson
            .map((e) => generator.build(e as Map<String, dynamic>))
            .toList(),
      );
    }

    return Container(padding: padding, color: color, child: child);
  }
}
