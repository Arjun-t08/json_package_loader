import 'package:flutter/widgets.dart';
import '../parser.dart';

/// A parser for the [Text] widget.
/// Expected JSON:
/// {
///   "type": "Text",
///   "data": "Hello World",
///   "fontSize": 20.0,
///   "color": "0xFFFF0000" // Alpha, Red, Green, Blue hex
/// }
class TextParser extends BaseWidgetParser {
  @override
  String get type => 'Text';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final data = json['data'] as String? ?? '';
    final fontSize = (json['fontSize'] as num?)?.toDouble();
    final colorHex = json['color'] as String?;

    Color? color;
    if (colorHex != null) {
      try {
        color = Color(int.parse(colorHex));
      } catch (e) {
        debugPrint('Invalid color hex: $colorHex');
      }
    }

    return Text(
      data,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
