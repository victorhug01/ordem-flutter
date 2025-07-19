import 'package:ordem/helpers/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InternetNotFoundView extends StatelessWidget {
  const InternetNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 30.0,
          children: [
            SizedBox(
              width: responsive.width,
              child: Lottie.asset(
                'assets/lotties/lottie404.json',
                width: 250,
                height: 250,
              ),
            ),

            Text(
              'Sem conexão',
              style: TextStyle(
                fontSize: TextTheme.of(context).headlineSmall!.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
