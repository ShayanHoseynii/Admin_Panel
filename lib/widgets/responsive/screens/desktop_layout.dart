import 'package:admin_panel/widgets/layouts/headers/header.dart';
import 'package:admin_panel/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: TSidebar()),
          // Main Content
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const THeader(),
                Expanded(child: body ?? Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
