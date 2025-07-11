// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:test_1/core/assets/app_assets.dart';
import 'package:test_1/presentation/bloc/splash_screen_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Dispatching NavigateToHomeEvent");
    BlocProvider.of<SplashScreenBloc>(context).add(NavigateToHomeEvent());
    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(
        body: _buildMaterialScaffold(context),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(
        body: _buildCupertinoScaffold(context),
      ),
    );
  }
}

Widget _buildMaterialScaffold(BuildContext context) {
  return Scaffold(
    body: BlocListener<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          debugPrint("Navigating to /home-screen");
          context.push('/home-screen');
        }
      },
      child: const SplashImageWidget(),
    ),
  );
}

Widget _buildCupertinoScaffold(BuildContext context) {
  return CupertinoPageScaffold(
    child: BlocListener<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          debugPrint("Navigating to /home-screen");
          context.push('/home-screen');
        }
      },
      child: const SplashImageWidget(),
    ),
  );
}

class SplashImageWidget extends StatelessWidget {
  const SplashImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: _width - 40,
        height: _width - 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Container(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.transparent
                : Colors.black,
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.appLogoNoBgURL,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
