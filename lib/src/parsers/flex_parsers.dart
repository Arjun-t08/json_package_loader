import 'package:flutter/widgets.dart';
import '../parser.dart';

/// Helper to parse axis alignments.
MainAxisAlignment _parseMainAxisAlignment(String? value) {
  switch (value) {
    case 'center':
      return MainAxisAlignment.center;
    case 'end':
      return MainAxisAlignment.end;
    case 'spaceBetween':
      return MainAxisAlignment.spaceBetween;
    case 'spaceAround':
      return MainAxisAlignment.spaceAround;
    case 'spaceEvenly':
      return MainAxisAlignment.spaceEvenly;
    default:
      return MainAxisAlignment.start;
  }
}

CrossAxisAlignment _parseCrossAxisAlignment(String? value) {
  switch (value) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'center':
      return CrossAxisAlignment.center;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    default:
      return CrossAxisAlignment.center;
  }
}

/// A parser for the [Column] widget.
class ColumnParser extends BaseWidgetParser {
  @override
  String get type => 'Column';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final childrenJson = json['children'] as List<dynamic>? ?? [];
    final mainAxisAlignment = _parseMainAxisAlignment(
      json['mainAxisAlignment'] as String?,
    );
    final crossAxisAlignment = _parseCrossAxisAlignment(
      json['crossAxisAlignment'] as String?,
    );

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: childrenJson
          .map((e) => generator.build(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// A parser for the [Row] widget.
class RowParser extends BaseWidgetParser {
  @override
  String get type => 'Row';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final childrenJson = json['children'] as List<dynamic>? ?? [];
    final mainAxisAlignment = _parseMainAxisAlignment(
      json['mainAxisAlignment'] as String?,
    );
    final crossAxisAlignment = _parseCrossAxisAlignment(
      json['crossAxisAlignment'] as String?,
    );

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: childrenJson
          .map((e) => generator.build(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
