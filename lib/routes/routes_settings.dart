import 'package:ordem/services/internet/connection.dart';
import 'package:ordem/services/supabse/supabase_service.dart';
import 'package:ordem/view/auth/alterPassword/alter_password_view.dart';
import 'package:ordem/view/auth/emailForResetPassword/email_for_reset_password_view.dart';
import 'package:ordem/view/auth/signUp/sign_up_view.dart';
import 'package:ordem/view/auth/verifyOTP/verify_otp_view.dart';
import 'package:ordem/view/home/home_view.dart';
import 'package:ordem/view/internet/internet_not_found_view.dart';
import 'package:ordem/view/auth/signIn/sign_in_view.dart';
import 'package:ordem/view/ordens/ordens_view.dart';
import 'package:ordem/view/products/products_view.dart';
import 'package:ordem/view/services/services_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routers {
  final GoRouter routesConfig = GoRouter(
    initialLocation: '/signIn',

    redirect: (context, state) {
      final hasConnection = ConnectionNotifier.of(context).value;
      final session = SupabaseService();

      const publicRoutes = {
        '/signIn',
        '/signUp',
        '/emailForResetPasswordView',
        '/verifyOTP',
        '/alterPasswordView',
      };

      if (!hasConnection) return '/connectivity';

      if (session.session == null &&!publicRoutes.contains(state.matchedLocation)) return '/signIn';

      if (session.session != null &&state.matchedLocation == '/alterPasswordView') return null;

      if (session.session != null && publicRoutes.contains(state.matchedLocation)) return '/';

      return null;
    },

    routes: <RouteBase>[
      GoRoute(
        path: '/signIn',
        name: 'signIn',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInView();
        },
      ),
      GoRoute(
        path: '/connectivity',
        name: 'connectivity',
        builder: (BuildContext context, GoRouterState state) {
          return const InternetNotFoundView();
        },
      ),
      GoRoute(
        path: '/',
        name: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: '/signUp',
        name: 'signUp',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpView();
        },
      ),
      GoRoute(
        path: '/emailForResetPasswordView',
        name: 'emailForResetPasswordView',
        builder: (BuildContext context, GoRouterState state) {
          return const EmailForResetPasswordView();
        },
      ),
      GoRoute(
        path: '/verifyOTP',
        name: 'verifyOTP',
        builder: (BuildContext context, GoRouterState state) {
          final email = state.extra as String? ?? '';
          return VerifyOTPView(email: email);
        },
      ),
      GoRoute(
        path: '/alterPasswordView',
        name: 'alterPasswordView',
        builder: (BuildContext context, GoRouterState state) {
          return const AlterPasswordView();
        },
      ),
      GoRoute(
        path: '/servicesView',
        name: 'servicesView',
        builder: (BuildContext context, GoRouterState state) {
          return const ServicesView();
        },
      ),
      GoRoute(
        path: '/ordens',
        name: 'ordens',
        builder: (BuildContext context, GoRouterState state) {
          return OrdensPage();
        },
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (BuildContext context, GoRouterState state) {
          return ProductsPage();
        },
      ),
    ],
  );
}
