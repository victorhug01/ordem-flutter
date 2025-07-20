import 'dart:async';
import 'package:ordem/viewmodel/services_viewmodel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ordem/app/theme.dart';
import 'package:ordem/routes/routes_settings.dart';
import 'package:ordem/services/internet/connection.dart';
import 'package:ordem/viewmodel/alter_password_viewmodel.dart';
import 'package:ordem/viewmodel/email_for_reset_password_viewmodel.dart';
import 'package:ordem/viewmodel/sign_in_viewmodel.dart';
import 'package:ordem/viewmodel/sign_out_viewmodel.dart';
import 'package:ordem/viewmodel/sign_up_viewmodel.dart';
import 'package:ordem/viewmodel/verify_otp_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<InternetConnectionStatus> listner;

  @override
  void initState() {
    super.initState();

    listner = InternetConnectionChecker.createInstance().onStatusChange.listen((status,) {
      final notifier = ConnectionNotifier.of(context);

      notifier.value =
          status == InternetConnectionStatus.connected ? true : false;
    });
  }

  @override
  void dispose() {
    listner.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routes = Routers();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => SignOutViewModel()),
        ChangeNotifierProvider(create: (_) => EmailForResetPasswordViewmodel()),
        ChangeNotifierProvider(create: (_) => VerifyOTPViewModel()),
        ChangeNotifierProvider(create: (_) => AlterPasswordViewmodel()),
        ChangeNotifierProvider(create: (_) => ServicesViewmodel()),
      ],
      child: MaterialApp.router(
        title: 'ordem flutter',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: ColorSchemeManagerClass.colorSecondary,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorSchemeManagerClass.colorSecondary,
            elevation: 0.0,
          ),
        ),

        supportedLocales: const [Locale('en', 'US'), Locale('pt', 'BR')],
        locale: const Locale('pt', 'BR'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        routerConfig: routes.routesConfig,
      ),
    );
  }
}
