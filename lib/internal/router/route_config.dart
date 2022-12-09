import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musik/pages/favorite/favorite_page.dart';
import 'package:musik/pages/music/music_page.dart';
import 'package:musik/pages/profile/profile_page.dart';
import 'package:musik/pages/search/search_page.dart';

import 'page_transition.dart';

enum AppPage{
  root(path: '/'),
  favorite(path: '/favorite'),
  feed(path: '/feed'),
  search(path: '/search'),
  profile(path: '/profile');


  const AppPage({
    required this.path,
    this.params = '',
  });

  final String path;
  final String? params;
}

extension AppPageRoute on AppPage {
  GoRoute route() {
    switch (this) {
      case AppPage.root:
        return GoRoute(
          path: path,
          name: name,
          redirect: (_, state) => AppPage.feed.path,
        );
      case AppPage.feed:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const MusicPage(),
          ),
        );
      case AppPage.favorite:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const FavoritePage(),
          ),
        );
      case AppPage.search:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const SearchPage(),
          ),
        );
      case AppPage.profile:
        return GoRoute(
          path: path,
          name: name,
          pageBuilder: (context, state) => PageTransition.fadeThrough(
            key: state.pageKey,
            child: const ProfilePage(),
          ),
        );
      default:
        return GoRoute(
          path: path,
          name: name,
          redirect: (_, state) => AppPage.feed.path,
        );
    }
  }
}

class RouteConfig{
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  static GlobalKey<NavigatorState> get rootKey => _rootNavigatorKey;

  static GlobalKey<NavigatorState> get nestedKey => _shellNavigatorKey;


  static GoRoute buildRoute(AppPage page) => page.route();

  static String? guard(BuildContext context, GoRouterState state) {
    bool loggedIn = true;

    /*if (loggedIn) {
      return AppPage.root.path;
    }*/
    return null;
  }
}

