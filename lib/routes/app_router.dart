import 'package:auto_route/auto_route.dart';
import 'package:flutter_app_2023/screens/login_screen.dart';
import 'package:flutter_app_2023/screens/main_tabs_screen.dart';
import 'package:flutter_app_2023/screens/search_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          path: "/login",
          page: LoginRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: "/tabs",
          page: MainTabsRoute.page,
        ),
      ];
}

class $AppRouter {}
