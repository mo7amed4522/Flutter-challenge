// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ================================ EVENT =========================== //
abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object?> get props => [];
}

class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;
  const ChangeLocaleEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}

// ============================= STATE ================================= //
class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState({required this.locale});

  @override
  List<Object?> get props => [locale];
}

// ============================ BOLC ================================== //
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(locale: Locale('en'))) {
    on<ChangeLocaleEvent>((event, emit) {
      emit(LocaleState(locale: event.locale));
    });
  }
}
