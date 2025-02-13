

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minner/app/app.dart';
import 'package:minner/features/Minners/views/minners_view.dart';
import 'package:minner/features/Profile/views/profile_view.dart';
import 'package:minner/features/home/views/home_view.dart';
import 'package:minner/features/login/views/login_view.dart';
import 'package:minner/features/mainWrapper/main_wrapper.dart';
import 'package:minner/features/settings/views/settings_view.dart';

final  _rootNavigatorKey = GlobalKey<NavigatorState>();
final  _rootNavigatorHome = GlobalKey<NavigatorState>();
final  _rootNavigatorProfile = GlobalKey<NavigatorState>();
final  _rootNavigatorMinerPage = GlobalKey<NavigatorState>();
final  _rootNavigatorSettings = GlobalKey<NavigatorState>();



final GoRouter _router= GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainPageWrapper(navigationShell: navigationShell,),
          branches:<StatefulShellBranch>[
            StatefulShellBranch(
                navigatorKey: _rootNavigatorHome,
                initialLocation: "/login",
                routes: [
                  GoRoute(
                    path: '/login',
                    name: 'login',
                    builder: (BuildContext context, GoRouterState state) {
                      return  SignInScreen();

                    },
                  ),

                ]),
            StatefulShellBranch(
                navigatorKey: _rootNavigatorMinerPage,
                initialLocation: "/miners",
                routes: [
                  GoRoute(
                    path: '/miners',
                    name: '/miners',
                    builder: (BuildContext context, GoRouterState state) {
                      return   MinersPage();

                    },
                  ),

                ]),
            StatefulShellBranch(
                navigatorKey: _rootNavigatorProfile,
                initialLocation: "/profile",
                routes: [
                  GoRoute(
                    path: '/profile',
                    name: '/profile',
                    builder: (BuildContext context, GoRouterState state) {
                      return  const ProfileScreen();

                    },
                  ),

                ]),
            StatefulShellBranch(
                navigatorKey: _rootNavigatorSettings,
                initialLocation: "/settings",
                routes: [
                  GoRoute(
                    path: '/settings',
                    name: '/settings',
                    builder: (BuildContext context, GoRouterState state) {
                      return   SettingsScreen();

                    },
                  ),

                ]),
          ]
      ),
      GoRoute(
        path: '/homepage',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return   HomeScreen(
           // key: state.pageKey,
          );

        },
      ),
    ]

);




get route {
  return _router;
}