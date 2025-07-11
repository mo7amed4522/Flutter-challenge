// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ===================== EVENT ===================== //
abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
  @override
  List<Object> get props => [];
}

class NavigateToHomeEvent extends SplashScreenEvent {}

// ===================== STATE ===================== //
abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class SplashScreenInitial extends SplashScreenState {}

class SplashNavigateToHome extends SplashScreenState {}

// ===================== BLOC ===================== //
class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<NavigateToHomeEvent>(_navigateToHomeScreen);
  }
  FutureOr<void> _navigateToHomeScreen(
    NavigateToHomeEvent event,
    Emitter<SplashScreenState> emit,
  ) async {
    debugPrint("NavigateToHomeEvent triggered");
    await Future.delayed(const Duration(seconds: 3));
    emit(SplashNavigateToHome());
    debugPrint("New State: SplashNavigateToHome");
  }
}
