import 'package:admin_panel/widgets/layouts/headers/header.dart';
import 'package:admin_panel/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});
  final GlobalKey<ScaffoldState> scaffoldKey =GlobalKey();
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const TSidebar(),
      appBar: THeader(scaffoldKey: scaffoldKey,),
      body: body ?? const Center(
        child: Text('No widget'),
      ),
    );
  }
}