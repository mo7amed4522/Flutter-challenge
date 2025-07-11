import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/app_bloc_observer.dart';
import 'package:test_1/core/routes/app_rotues.dart';
import 'package:test_1/l10n/app_localizations.dart';
import 'package:test_1/presentation/bloc/splash_screen_bloc.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/theme_bloc.dart';
import 'presentation/bloc/locale_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter error: ${details.exceptionAsString()}');
  };
  try {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(create: (_) => LocaleBloc()),
          BlocProvider(create: (_) => SplashScreenBloc()),
        ],
        child: RideHailingApp(),
      ),
    );
  } catch (e, stack) {
    runApp(
      MaterialApp(
        home: Scaffold(body: Center(child: Text('Initialization error: $e'))),
      ),
    );
    debugPrint('Error during initialization: $e\\n$stack');
  }
}

class RideHailingApp extends StatelessWidget {
  const RideHailingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformApp.router(
      title: AppLocalizations.of(context)?.appTitle ?? 'Ride Hailing',
      material: (_, __) => MaterialAppRouterData(
        theme: AppTheme.customLightThem,
        darkTheme: AppTheme.customDarkThem,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
      cupertino: (_, __) => CupertinoAppRouterData(
        theme: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppTheme.cupertinoDarkTheme
            : AppTheme.cupertinoLightTheme,
        debugShowCheckedModeBanner: false,
      ),
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        if (child == null) {
          return Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context)?.localeName ??
                  'Router returned null (no screen to display)'),
            ),
          );
        }
        return child;
      },
    );
  }
}
