import 'package:flutter/material.dart';
class TResponsiveWidget extends StatelessWidget {
  const TResponsiveWidget({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  /// Widget for desktop layout
  final Widget desktop;

  /// Widget for tablet layout
  final Widget tablet;

  /// Widget for mobile layout
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= 1366) {
          return desktop;
        } else if (constraints.maxWidth >= 768) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
