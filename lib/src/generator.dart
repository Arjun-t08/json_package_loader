import 'package:flutter/widgets.dart';
import 'parser.dart';
import 'registry.dart';

/// Concrete implementation of the JSON widget generator.
class JsonWidgetGenerator implements IJsonWidgetGenerator {
  final IWidgetRegistry _registry;

  JsonWidgetGenerator({IWidgetRegistry? registry})
    : _registry = registry ?? WidgetRegistry();

  @override
  Widget build(Map<String, dynamic> json) {
    try {
      final type = json['type'] as String?;
      if (type == null) {
        return const JsonErrorWidget('Missing "type" property in JSON');
      }

      final parser = _registry.getParser(type);
      if (parser == null) {
        debugPrint('Warning: No parser registered for type "$type"');
        return const SizedBox.shrink();
      }

      return parser.parse(json, this);
    } catch (e, stackTrace) {
      debugPrint('Critical error in JsonWidgetGenerator: $e\n$stackTrace');
      return JsonErrorWidget('Generator Failure: $e');
    }
  }
}
