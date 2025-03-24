import 'package:cabeleleila/services/internet/connection.dart';
import 'package:cabeleleila/services/supabse/supabase_service.dart';
import 'package:cabeleleila/view/auth/alterPassword/alter_password_view.dart';
import 'package:cabeleleila/view/auth/emailForResetPassword/email_for_reset_password_view.dart';
import 'package:cabeleleila/view/history/history_view.dart';
import 'package:cabeleleila/view/navigationScreens/navigation_screens_view.dart';
import 'package:cabeleleila/view/auth/signUp/sign_up_view.dart';
import 'package:cabeleleila/view/auth/verifyOTP/verify_otp_view.dart';
import 'package:cabeleleila/view/home/home_view.dart';
import 'package:cabeleleila/view/internet/internet_not_found_view.dart';
import 'package:cabeleleila/view/auth/signIn/sign_in_view.dart';
import 'package:cabeleleila/view/services/services_view.dart';
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

      if(!hasConnection) return '/connectivity';

      if(session.session ==  null && !publicRoutes.contains(state.matchedLocation)) return '/signIn';

      if (session.session != null && state.matchedLocation == '/alterPasswordView') return null;


      if(session.session != null && publicRoutes.contains(state.matchedLocation)) return '/navigationScreens';

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
        path: '/home',
        name: 'home',
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
        path: '/navigationScreens',
        name: 'navigationScreens',
        builder: (BuildContext context, GoRouterState state) {
          return const NavigationScreensView();
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
        path: '/history',
        name: 'history',
        builder: (BuildContext context, GoRouterState state) {
          return const HistoryView();
        },
      ),
    ]
  );
}