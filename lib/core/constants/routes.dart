import 'package:go_router/go_router.dart';
import 'package:photobooth/presentation/screens/idle/idle_screen.dart';
import 'package:photobooth/presentation/screens/packages/package_list_screen.dart';
import 'package:photobooth/presentation/screens/payment/payment_screen.dart';
import 'package:photobooth/presentation/screens/frame/frame_list_screen.dart';
import 'package:photobooth/presentation/screens/session/session_screen.dart';
import 'package:photobooth/presentation/screens/result/result_screen.dart';
import 'package:photobooth/presentation/screens/admin/admin_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/',          builder: (_, __) => const IdleScreen()),
    GoRoute(path: '/packages',  builder: (_, __) => const PackageListScreen()),
    GoRoute(
      path: '/payment/:paketId',
      builder: (_, state) => PaymentScreen(
        paketId: int.parse(state.pathParameters['paketId']!),
      ),
    ),
    GoRoute(
      path: '/frame/:sesiId',
      builder: (_, state) => FrameListScreen(
        sesiId: int.parse(state.pathParameters['sesiId']!),
      ),
    ),
    GoRoute(
      path: '/session/:sesiId',
      builder: (_, state) => SessionScreen(
        sesiId: int.parse(state.pathParameters['sesiId']!),
      ),
    ),
    GoRoute(
      path: '/result/:sesiId',
      builder: (_, state) => ResultScreen(
        sesiId: int.parse(state.pathParameters['sesiId']!),
      ),
    ),
    GoRoute(path: '/admin', builder: (_, __) => const AdminScreen()),
  ],
);
