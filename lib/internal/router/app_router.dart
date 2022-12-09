import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musik/pages/main_page.dart';

import 'route_config.dart';

class AppRouter{
  final GoRouter _goRouter;
  GoRouter get goRouter => _goRouter;

  AppRouter()
      : _goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppPage.root.path,
    redirect: RouteConfig.guard,
    routes: [
      ShellRoute(
        builder: (_, state, child) => MainPage(child: child),
        navigatorKey: RouteConfig.nestedKey,
        routes: [
          RouteConfig.buildRoute(AppPage.root),
          RouteConfig.buildRoute(AppPage.feed),
          RouteConfig.buildRoute(AppPage.favorite),
          RouteConfig.buildRoute(AppPage.search),
          RouteConfig.buildRoute(AppPage.profile),
        ],
      ),
    ],
  );
}

