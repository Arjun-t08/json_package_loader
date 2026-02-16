import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_page_loader/json_page_loader.dart';

void main() {
  group('WidgetRegistry Tests', () {
    late WidgetRegistry registry;

    setUp(() {
      registry = WidgetRegistry();
    });

    test('Should register and retrieve a parser', () {
      final parser = MockParser();
      registry.register(parser);
      expect(registry.getParser('Mock'), equals(parser));
    });

    test('Should return null for non-existent parser', () {
      expect(registry.getParser('NonExistent'), isNull);
    });
  });

  group('JsonWidgetGenerator Tests', () {
    late JsonWidgetGenerator generator;
    late WidgetRegistry registry;

    setUp(() {
      registry = WidgetRegistry();
      generator = JsonWidgetGenerator(registry: registry);
    });

    test('Should return JsonErrorWidget when type is missing', () {
      final result = generator.build({});
      expect(result, isA<JsonErrorWidget>());
    });

    test('Should return SizedBox.shrink when parser is not found', () {
      final result = generator.build({'type': 'Unknown'});
      expect(result, isA<SizedBox>());
    });

    test('Should call parser when type is registered', () {
      final parser = MockParser();
      registry.register(parser);
      final result = generator.build({'type': 'Mock'});
      expect(result, isA<Text>());
      expect((result as Text).data, equals('Mock Widget'));
    });
  });
}

class MockParser extends BaseWidgetParser {
  @override
  String get type => 'Mock';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    return const Text('Mock Widget');
  }
}
