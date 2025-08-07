import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class RouteObservers extends GetObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sideBarController = Get.put(SidebarController());

    if (previousRoute != null) {
      for (var routeName in TRoutes.sidBarMenuItems) {
        if (previousRoute.settings.name == routeName) {
          sideBarController.activeItem.value = routeName;
        }
      }
    }
  }
}
