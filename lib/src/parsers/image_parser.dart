import 'package:flutter/widgets.dart';
import '../parser.dart';

/// A parser for the [Image] widget.
/// Expected JSON:
/// {
///   "type": "Image",
///   "url": "https://example.com/image.png",
///   "width": 100.0,
///   "height": 100.0,
///   "fit": "cover"
/// }
class ImageParser extends BaseWidgetParser {
  @override
  String get type => 'Image';

  @override
  Widget build(Map<String, dynamic> json, IJsonWidgetGenerator generator) {
    final url = json['url'] as String?;
    final width = (json['width'] as num?)?.toDouble();
    final height = (json['height'] as num?)?.toDouble();
    final fitString = json['fit'] as String?;

    BoxFit fit = BoxFit.contain;
    switch (fitString) {
      case 'cover':
        fit = BoxFit.cover;
        break;
      case 'fill':
        fit = BoxFit.fill;
        break;
      case 'fitHeight':
        fit = BoxFit.fitHeight;
        break;
      case 'fitWidth':
        fit = BoxFit.fitWidth;
        break;
      case 'none':
        fit = BoxFit.none;
        break;
    }

    if (url == null) {
      return const SizedBox.shrink();
    }

    // Using network image for demonstration
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: const Color(0xFFEEEEEE),
          child: const Center(
            child: Icon(IconData(0xe2ee, fontFamily: 'MaterialIcons')),
          ), // error icon
        );
      },
    );
  }
}
