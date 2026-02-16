import 'package:flutter/widgets.dart';

/// Interface for widget parsers.
/// Defines the contract for parsing JSON into a Flutter [Widget].
abstract interface class IWidgetParser {
  /// The type string this parser handles (e.g., 'Text', 'Container').
  String get type;

  /// Parses the provided [json] and returns a [Widget].
  /// [generator] is provided for recursive rendering of nested children.
  Widget parse(Map<String, dynamic> json, IJsonWidgetGenerator generator);
}

/// Interface for the JSON widget generator.
/// Used to avoid circular dependencies and allow recursive calls from parsers.
abstract interface class IJsonWidgetGenerator {
  /// Builds a widget from the given [json].
  Widget build(Map<String, dynamic> json);
}

/// Base class for widget parsers providing common utility methods.
abstract class BaseWidgetParser implements IWidgetParser {
  @override
  Widget parse(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    try {
      return build(json, generator);
    } catch (e, stackTrace) {
      debugPrint('Error parsing widget of type $type: $e\n$stackTrace');
      return JsonErrorWidget('Parsing Error: $e');
    }
  }

  /// Implementation specific build method.
  @protected
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator);
}

/// A simple JsonErrorWidget to display when something goes wrong.
class JsonErrorWidget extends StatelessWidget {
  final String message;
  const JsonErrorWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFFFF0000),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
