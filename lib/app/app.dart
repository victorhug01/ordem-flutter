import 'dart:async';
import 'package:cabeleleila/viewmodel/services_viewmodel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/routes/routes_settings.dart';
import 'package:cabeleleila/services/internet/connection.dart';
import 'package:cabeleleila/viewmodel/alter_password_viewmodel.dart';
import 'package:cabeleleila/viewmodel/email_for_reset_password_viewmodel.dart';
import 'package:cabeleleila/viewmodel/sign_in_viewmodel.dart';
import 'package:cabeleleila/viewmodel/sign_out_viewmodel.dart';
import 'package:cabeleleila/viewmodel/sign_up_viewmodel.dart';
import 'package:cabeleleila/viewmodel/verify_otp_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

/// Classe principal do aplicativo que utiliza um [StatefulWidget].
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Listener para monitorar o status da conexão com a internet.
  late final StreamSubscription<InternetConnectionStatus> listner;

  @override
  void initState() {
    super.initState();
    
    // Inicia o listener para monitorar mudanças no status da conexão com a internet.
    listner = InternetConnectionChecker.createInstance().onStatusChange.listen((status) {
      final notifier = ConnectionNotifier.of(context);
      
      // Atualiza o estado da conexão conforme a resposta do InternetConnectionChecker.
      notifier.value = status == InternetConnectionStatus.connected ? true : false;
    });
  }

  @override
  void dispose() {
    // Cancela o listener quando o widget for descartado.
    listner.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routes = Routers();
    
    return MultiProvider(
      providers: [
        // Fornece os ViewModels necessários para a aplicação.
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => SignOutViewModel()),
        ChangeNotifierProvider(create: (_) => EmailForResetPasswordViewmodel()),
        ChangeNotifierProvider(create: (_) => VerifyOTPViewModel()),
        ChangeNotifierProvider(create: (_) => AlterPasswordViewmodel()),
        ChangeNotifierProvider(create: (_) => ServicesViewmodel()),
      ],
      child: MaterialApp.router(
        title: 'Cabeleleila Leila',
        debugShowCheckedModeBanner: false,
        
        // Define o tema principal da aplicação.
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: ColorSchemeManagerClass.colorSecondary,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorSchemeManagerClass.colorSecondary,
            elevation: 0.0,
          ),
        ),
        
        // Configura as localizações suportadas no app.
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        
        // Configuração das rotas da aplicação.
        routerConfig: routes.routesConfig,
      ),
    );
  }
}