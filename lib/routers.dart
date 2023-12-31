import 'package:go_router/go_router.dart';
import 'package:meeting_room/features/booking/presentation/booking_screen.dart';

import 'core/constants/route_path.dart';
import 'core/domain/entity/room.dart';
import 'features/auth/presentation/auth_screen.dart';
import 'features/my_booking/presentation/my_booking_screen.dart';
import 'features/room_list/presentation/room_list_screen.dart';
import 'features/scan_qr_code/scan_qr_code_screen.dart';
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
      GoRoute(
        path: RoutePath.roomList,
        builder: (context, state) => const RoomListScreen(),
      ),
      GoRoute(
        path: RoutePath.book,
        builder: (context, state) {
          Room room = state.extra as Room;
          return BookingScreen(room: room,);
        },
      ),
      GoRoute(
        path: RoutePath.qrScanner,
        builder: (context, state) => const ScanQrCodeScreen(),
      ),
      GoRoute(
        path: RoutePath.myBooking,
        builder: (context, state) => const MyBookingScreen(),
      ),
    ]
  );
}
