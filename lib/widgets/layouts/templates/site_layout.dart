import 'package:admin_panel/widgets/responsive/responsive_design.dart';
import 'package:admin_panel/widgets/responsive/screens/desktop_layout.dart';
import 'package:admin_panel/widgets/responsive/screens/mobile_layout.dart';
import 'package:admin_panel/widgets/responsive/screens/tablet_layout.dart';
import 'package:flutter/material.dart';

class TSiteTemplate extends StatelessWidget {
  const TSiteTemplate({super.key, this.desktop, this.tablet, this.mobile,  this.useLayout = true});
  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;
  final bool useLayout;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TResponsiveWidget(
          desktop: useLayout? DesktopLayout(
            body: desktop,
          ) : desktop?? const Text('Desktop Layout Not Provided'),
          tablet: useLayout? TabletLayout(body: tablet ?? desktop) : tablet ?? desktop?? Container(),
          mobile:useLayout? MobileLayout(body: mobile ?? desktop) : mobile ?? desktop?? Container()),
    );
  }
}
