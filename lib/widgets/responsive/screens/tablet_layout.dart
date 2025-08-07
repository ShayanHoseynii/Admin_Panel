import 'package:admin_panel/widgets/layouts/headers/header.dart';
import 'package:admin_panel/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const TSidebar(),
      appBar: THeader(
        scaffoldKey: scaffoldKey,
      ),
      body: body ??
          Container(
            child: const Text('No widget'),
          ),
    );
  }
}
