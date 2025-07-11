import 'package:go_router/go_router.dart';
import 'package:test_1/presentation/bloc/select_taxi_bloc.dart';
import 'package:test_1/presentation/view/home_screen.dart';
import 'package:test_1/presentation/view/select_texi_screen.dart';
import 'package:test_1/presentation/view/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/presentation/bloc/home_screen_bloc.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/home-screen',
      builder: (context, state) => BlocProvider(
        create: (_) => HomeScreenBloc(),
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/select-taxi-screen',
      builder: (context, state) => BlocProvider(
        create: (_) => SelectTaxiBloc(),
        child: const SelectTexiScreen(),
      ),
    ),
  ],
);
