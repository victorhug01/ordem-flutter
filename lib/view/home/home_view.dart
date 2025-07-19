import 'package:ordem/app/theme.dart';
import 'package:ordem/models/sign_out_model.dart';
import 'package:ordem/viewmodel/sign_out_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ordem/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Home"),
        actions: [
          _isLoggingOut
              ? const CircularProgressIndicator()
              : IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () async {
                  setState(() {
                    _isLoggingOut = true;
                  });

                  await context.read<SignOutViewModel>().signOut(
                    SignOutModel(),
                    context,
                  );

                  setState(() {
                    _isLoggingOut = false;
                  });
                },
              ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ButtonWidget(
              color: ColorSchemeManagerClass.colorPrimary,
              title: Text(
                'Conectar',
                style: TextStyle(
                  color: ColorSchemeManagerClass.colorSecondary,
                  fontSize: TextTheme.of(context).titleMedium!.fontSize,
                ),
              ),
              radius: 10.0,
              height: 55.0,
              width: 1.7,
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
