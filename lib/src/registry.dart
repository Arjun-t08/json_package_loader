import 'parser.dart';

/// Interface for the widget registry.
abstract interface class IWidgetRegistry {
  /// Registers a parser for a given widget type.
  void register(IWidgetParser parser);

  /// Retrieves a parser for a given widget type.
  IWidgetParser? getParser(String type);
}

/// Singleton implementation of the widget registry.
/// This allows for easy extensibility without modifying the core engine.
class WidgetRegistry implements IWidgetRegistry {
  WidgetRegistry._internal();
  static final WidgetRegistry _instance = WidgetRegistry._internal();
  factory WidgetRegistry() => _instance;

  final Map<String, IWidgetParser> _parsers = {};

  @override
  void register(IWidgetParser parser) {
    _parsers[parser.type] = parser;
  }

  @override
  IWidgetParser? getParser(String type) {
    return _parsers[type];
  }
}
