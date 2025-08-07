import 'package:admin_panel/features/media/screens/media/responsive_screens/media_desktop.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: MediaDesktopScreen(),
    );
  }
}
