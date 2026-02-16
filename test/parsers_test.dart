import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_page_loader/json_page_loader.dart';

void main() {
  late JsonWidgetGenerator generator;
  late WidgetRegistry registry;

  setUp(() {
    registry = WidgetRegistry();
    registry.register(TextParser());
    registry.register(ContainerParser());
    registry.register(PaddingParser());
    registry.register(SizedBoxParser());
    generator = JsonWidgetGenerator(registry: registry);
  });

  group('TextParser Widget Tests', () {
    testWidgets('Should render Text with correct data and style', (
      tester,
    ) async {
      final json = {
        'type': 'Text',
        'data': 'Test Text',
        'fontSize': 24.0,
        'color': '0xFFFF0000',
      };

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: generator.build(json),
        ),
      );

      final textFinder = find.text('Test Text');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, equals(24.0));
      expect(textWidget.style?.color, equals(const Color(0xFFFF0000)));
    });
  });

  group('ContainerParser Widget Tests', () {
    testWidgets('Should render Container with color and padding', (
      tester,
    ) async {
      final json = {
        'type': 'Container',
        'color': '0xFF00FF00',
        'padding': {'left': 10, 'top': 20, 'right': 30, 'bottom': 40},
        'child': {'type': 'Text', 'data': 'Inside Container'},
      };

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: generator.build(json),
        ),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final containerWidget = tester.widget<Container>(containerFinder);
      expect(containerWidget.color, equals(const Color(0xFF00FF00)));
      expect(
        containerWidget.padding,
        equals(const EdgeInsets.fromLTRB(10, 20, 30, 40)),
      );
      expect(find.text('Inside Container'), findsOneWidget);
    });
  });

  group('PaddingParser Widget Tests', () {
    testWidgets('Should render Padding with correct edge insets', (
      tester,
    ) async {
      final json = {
        'type': 'Padding',
        'padding': {'left': 5, 'top': 5, 'right': 5, 'bottom': 5},
        'child': {'type': 'Text', 'data': 'Padded Text'},
      };

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: generator.build(json),
        ),
      );

      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsOneWidget);

      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(paddingWidget.padding, equals(const EdgeInsets.all(5)));
    });
  });
}
