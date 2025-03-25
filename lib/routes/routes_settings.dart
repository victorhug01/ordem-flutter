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

/// Classe responsável pela configuração das rotas de navegação da aplicação.
class Routers {
  /// Instância do [GoRouter] que gerencia as rotas e redirecionamentos da aplicação.
  final GoRouter routesConfig = GoRouter(
    initialLocation: '/signIn',  // A página inicial é a tela de login.
    
    /// Função de redirecionamento que decide para qual rota o usuário deve ser enviado.
    redirect: (context, state) {
      final hasConnection = ConnectionNotifier.of(context).value;  // Verifica a conexão com a internet.
      final session = SupabaseService();  // Serviço de autenticação para verificar a sessão ativa.
      
      // Definindo rotas públicas onde o usuário pode acessar sem estar autenticado.
      const publicRoutes = {
        '/signIn',
        '/signUp',
        '/emailForResetPasswordView',
        '/verifyOTP',
        '/alterPasswordView',
      };

      // Se não houver conexão, redireciona para a tela de erro de conexão.
      if (!hasConnection) return '/connectivity';

      // Se não houver sessão e a rota não for pública, redireciona para a tela de login.
      if (session.session == null && !publicRoutes.contains(state.matchedLocation)) return '/signIn';

      // Se a sessão estiver ativa e a rota for a de alterar senha, mantém o usuário na mesma tela.
      if (session.session != null && state.matchedLocation == '/alterPasswordView') return null;

      // Se a sessão estiver ativa e a rota for pública, redireciona para a tela de navegação.
      if (session.session != null && publicRoutes.contains(state.matchedLocation)) return '/navigationScreens';

      return null;  // Retorna null para permitir a navegação normal se não houver condições de redirecionamento.
    },

    // Definição das rotas e seus respectivos componentes de tela.
    routes: <RouteBase>[
      GoRoute(
        path: '/signIn',
        name: 'signIn',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInView();  // Tela de login.
        },
      ),
      GoRoute(
        path: '/connectivity',
        name: 'connectivity',
        builder: (BuildContext context, GoRouterState state) {
          return const InternetNotFoundView();  // Tela de erro de conexão.
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();  // Tela principal após o login.
        },
      ),
      GoRoute(
        path: '/signUp',
        name: 'signUp',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpView();  // Tela de cadastro.
        },
      ),
      GoRoute(
        path: '/emailForResetPasswordView',
        name: 'emailForResetPasswordView',
        builder: (BuildContext context, GoRouterState state) {
          return const EmailForResetPasswordView();  // Tela para solicitar o e-mail de redefinição de senha.
        },
      ),
      GoRoute(
        path: '/verifyOTP',
        name: 'verifyOTP',
        builder: (BuildContext context, GoRouterState state) {
          final email = state.extra as String? ?? '';  // Recupera o e-mail passado na navegação.
          return VerifyOTPView(email: email);  // Tela de verificação do código OTP.
        },
      ),
      GoRoute(
        path: '/alterPasswordView',
        name: 'alterPasswordView',
        builder: (BuildContext context, GoRouterState state) {
          return const AlterPasswordView();  // Tela para alterar a senha.
        },
      ),
      GoRoute(
        path: '/navigationScreens',
        name: 'navigationScreens',
        builder: (BuildContext context, GoRouterState state) {
          return const NavigationScreensView();  // Tela de navegação principal após login.
        },
      ),
      GoRoute(
        path: '/servicesView',
        name: 'servicesView',
        builder: (BuildContext context, GoRouterState state) {
          return const ServicesView();  // Tela para exibir serviços disponíveis no salão.
        },
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (BuildContext context, GoRouterState state) {
          return const HistoryView();  // Tela para exibir o histórico de agendamentos do usuário.
        },
      ),
    ]
  );
}
