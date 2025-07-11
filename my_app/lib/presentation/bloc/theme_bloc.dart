// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ========================= EVENT ===========================  //

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}

// ========================= STATE ===========================  //
class ThemeState extends Equatable {
  final bool isDark;
  const ThemeState({required this.isDark});

  @override
  List<Object?> get props => [isDark];
}

// ========================= BLOC ===========================  //
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDark: false)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeState(isDark: !state.isDark));
    });
  }
}
