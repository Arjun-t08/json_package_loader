import 'package:flutter/widgets.dart';
import '../parser.dart';

/// A parser for the [SizedBox] widget.
/// Expected JSON:
/// {
///   "type": "SizedBox",
///   "width": 100.0,
///   "height": 50.0,
///   "child": { ... }
/// }
class SizedBoxParser extends BaseWidgetParser {
  @override
  String get type => 'SizedBox';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final width = (json['width'] as num?)?.toDouble();
    final height = (json['height'] as num?)?.toDouble();
    final childJson = json['child'] as Map<String, dynamic>?;

    return SizedBox(
      width: width,
      height: height,
      child: childJson != null ? generator.build(childJson) : null,
    );
  }
}
