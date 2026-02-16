import 'package:flutter/material.dart';
import 'package:json_page_loader/json_page_loader.dart';

void main() {
  final registry = WidgetRegistry();

  // Register all core parsers
  registry.register(TextParser());
  registry.register(ContainerParser());
  registry.register(PaddingParser());
  registry.register(SizedBoxParser());
  registry.register(RowParser());
  registry.register(ColumnParser());
  registry.register(ImageParser());

  // Demonstrate Custom Widget Registration
  registry.register(CustomCardParser());

  runApp(const JsonUIExampleApp());
}

class JsonUIExampleApp extends StatelessWidget {
  const JsonUIExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final generator = JsonWidgetGenerator();

    // A complex JSON structure representing a modern dashboard
    final Map<String, dynamic> dashboardJson = {
      "type": "Container",
      "color": "0xFFF0F2F5",
      "child": {
        "type": "Column",
        "crossAxisAlignment": "stretch",
        "children": [
          // Header Section
          {
            "type": "Container",
            "color": "0xFF2196F3",
            "padding": {"left": 20, "top": 60, "right": 20, "bottom": 30},
            "child": {
              "type": "Row",
              "mainAxisAlignment": "spaceBetween",
              "children": [
                {
                  "type": "Column",
                  "crossAxisAlignment": "start",
                  "children": [
                    {
                      "type": "Text",
                      "data": "Smart Home",
                      "fontSize": 24.0,
                      "color": "0xFFFFFFFF",
                    },
                    {
                      "type": "Text",
                      "data": "Monday, Feb 16",
                      "fontSize": 14.0,
                      "color": "0xFFE3F2FD",
                    },
                  ],
                },
                {
                  "type": "Image",
                  "url":
                      "https://api.dicebear.com/7.x/avataaars/png?seed=Arjun",
                  "width": 50.0,
                  "height": 50.0,
                  "fit": "cover",
                },
              ],
            },
          },
          // Stats Row
          {
            "type": "Padding",
            "padding": {"left": 20, "top": 20, "right": 20, "bottom": 10},
            "child": {
              "type": "Row",
              "mainAxisAlignment": "spaceBetween",
              "children": [
                {
                  "type": "CustomCard",
                  "title": "Temperature",
                  "value": "24°C",
                  "icon": "0xe30d", // thermostat
                },
                {
                  "type": "CustomCard",
                  "title": "Humidity",
                  "value": "45%",
                  "icon": "0xe6b8", // water_drop
                },
              ],
            },
          },
          // Device List
          {
            "type": "Padding",
            "padding": {"left": 20, "top": 10},
            "child": {
              "type": "Text",
              "data": "Active Devices",
              "fontSize": 18.0,
              "color": "0xFF333333",
            },
          },
          {
            "type": "Container",
            "padding": {"left": 20, "top": 10, "right": 20},
            "child": {
              "type": "Column",
              "children": [
                _deviceItem("Light - Living Room", "ON"),
                _deviceItem("Air Purifier", "STANDBY"),
                _deviceItem("Smart TV", "OFF"),
              ],
            },
          },
        ],
      },
    };

    return Scaffold(
      body: SingleChildScrollView(child: generator.build(dashboardJson)),
    );
  }

  static Map<String, dynamic> _deviceItem(String name, String status) {
    return {
      "type": "Container",
      "color": "0xFFFFFFFF",
      "padding": {"left": 15, "top": 15, "right": 15, "bottom": 15},
      "child": {
        "type": "Row",
        "mainAxisAlignment": "spaceBetween",
        "children": [
          {
            "type": "Text",
            "data": name,
            "fontSize": 16.0,
            "color": "0xFF333333",
          },
          {
            "type": "Text",
            "data": status,
            "fontSize": 14.0,
            "color": status == "ON" ? "0xFF4CAF50" : "0xFF9E9E9E",
          },
        ],
      },
    };
  }
}

/// A Custom Parser demonstrating how users can extend the engine.
class CustomCardParser extends BaseWidgetParser {
  @override
  String get type => 'CustomCard';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final title = json['title'] as String? ?? '';
    final value = json['value'] as String? ?? '';
    final iconProp = json['icon'] as String? ?? '0xe0b0';

    return Container(
      width: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            IconData(int.parse(iconProp), fontFamily: 'MaterialIcons'),
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
