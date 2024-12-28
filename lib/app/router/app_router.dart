import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../models/ModelProvider.dart';
import '../../pages/account_viewer/account_viewer.dart';
import '../../pages/bottom_navbar/bottom_navbar.dart';
import '../../pages/dynamic_viewer/dynamic_viewer.dart';
import '../../pages/local_authentication/local_authentication.dart';
import '../../pages/login/login.dart';
import '../../pages/notifications/notifications.dart';
import '../../pages/notifications_viewer/notifications_viewer.dart';
import '../../pages/receipt/views/receipt_page.dart';
import '../../pages/scanner/scanner.dart';
import '../../pages/scanner_transaction/scanner_transaction.dart';
import '../../pages/sign_up/sign_up.dart';
import '../../pages/sign_up_confirm/sign_up_confirm.dart';
import '../../pages/sign_up_verify/sign_up_verify.dart';
import '../../pages/walk_through/walk_through.dart';
import '../../splash/splash.dart';
import '../../utils/utils.dart';
import '../app.dart';
import '../widgets/widgets.dart';

class AppRouter {
  static GoRouter router(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return GoRouter(
      initialLocation: '/splash',
      routes: [
        // splash
        GoRoute(
          name: RouteName.splash,
          path: '/splash',
          builder: (context, state) => const Splash(),
        ),
        // walkthrough
        GoRoute(
          name: RouteName.walkThrough,
          path: '/walkThrough',
          builder: (context, state) => const WalkThroughPage(),
        ),
        // login
        GoRoute(
          name: RouteName.login,
          path: '/login',
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              name: RouteName.signUpVerify,
              path: 'signUpVerify',
              builder: (context, state) => const SignUpVerifyPage(),
            ),
            GoRoute(
              name: RouteName.signUp,
              path: 'signUp/:accountNumber',
              builder: (context, state) => SignupRoute(accountNumber: state.pathParameters['accountNumber']),
            ),
            GoRoute(
              name: RouteName.signUpConfirm,
              path: 'signUpConfirm/:username',
              builder: (context, state) => SignUpConfirmPage(username: state.pathParameters['username']),
            )
          ]
        ),
        // authentication
        GoRoute(
          name: RouteName.authPin,
          path: '/',
          builder: (context, state) => const AuthPinPage(),
          routes: [
            GoRoute(
              name: RouteName.createPin,
              path: 'createPin',
              builder: (context, state) => const CreatePinPage()
            ),
            GoRoute(
              name: RouteName.updatePin,
              path: 'updatePin',
              builder: (context, state) => const UpdatePinPage()
            )
          ]
        ),
        // bottom navbar
        GoRoute(
          name: RouteName.bottomNavbar,
          path: '/bottomNavbar',
          builder: (context, state) => const BottomNavbarPage(),
          routes: [
            GoRoute(
              name: RouteName.account,
              path: 'account',
              builder: (context, state) {
                Account account = state.extra as Account;
                return AccountPage(account: account);
              }
            ),
            GoRoute(
              name: RouteName.notification,
              path: 'notification',
              builder: (context, state) => const NotificationPage(),
              routes: [
                GoRoute(
                  name: RouteName.notificationViewer,
                  path: 'notificationViewer/:id',
                  builder: (context, state) => NotificationsViewerPage(id: state.pathParameters['id']),
                )
              ]
            ),
            GoRoute(
              name: RouteName.scanner,
              path: 'scanner',
              builder: (context, state) => const ScannerPage(),
              routes: [
                GoRoute(
                  name: RouteName.scannerTransaction,
                  path: 'scannerTransaction',
                  builder: (context, state) => const ScannerTransactionPage(),
                )
              ]
            ),
            GoRoute(
              name: RouteName.receipt,
              path: 'receipt',
              builder: (context, state) => const ReceiptPage(),
            ),
            GoRoute(
              name: RouteName.dynamicViewer,
              path: 'dynamicViewer',
              builder: (context, state) {
                Button button = state.extra as Button;
                return DynamicViewerPage(button: button);
              },
            )
          ]  
        )
      ],
      refreshListenable: StreamToListenable(appBloc.stream),
      redirect: (context, state) {
        final authBloc = appBloc.state.status;
        final onSplashPage = state.matchedLocation == '/splash';

        // // Define protected routes
        // final protectedPaths = ['/dashboard', '/profile', '/settings'];

        // // Check if the current route is a protected route
        // final isProtectedRoute = protectedPaths.contains(state.matchedLocation);

        // // Handle unauthenticated users on protected routes
        // if (isUnauthenticated && isProtectedRoute) {
        //   return '/login?redirect=${state.matchedLocation}';
        // }
        
        // unauthenticated
        if (authBloc.isUnauthenticated && onSplashPage) {
          return '/login';
        }
        // authenticated
        if (authBloc.isAuthenticated && onSplashPage) { 
          return '/';
        }
        return null;
      },
      observers: [MyNavigatorObserver()]
    );
  }
}