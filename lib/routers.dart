import 'package:go_router/go_router.dart';

import 'core/constants/route_path.dart';
import 'features/auth/presentation/auth_screen.dart';
import 'features/subscribe/presentation/subscribe_screen.dart';

class AppRouter {
  static GoRouter configurations = GoRouter(
    initialLocation: RoutePath.signIn,
    routes: [
      GoRoute(
        path: RoutePath.signIn,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RoutePath.signUp,
        builder: (context, state) => const SubscribeScreen(),
      ),
    ]
  );
}
