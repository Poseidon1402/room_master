import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/constants/route_path.dart';

class AppRouter {
  static GoRouter configurations = GoRouter(
    initialLocation: RoutePath.signIn,
    routes: [
      GoRoute(
        path: RoutePath.signIn,
        builder: (context, state) => Container(color: Colors.red),
      ),
    ]
  );
}
