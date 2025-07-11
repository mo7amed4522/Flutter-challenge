// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_1/core/assets/app_assets.dart';

enum TaxiTab { economy, luxury, taxicab }

class CarOption extends Equatable {
  final String id;
  final String imageAsset;
  final String size;
  final String price;
  final String capacity;
  final String time;

  const CarOption({
    required this.id,
    required this.imageAsset,
    required this.size,
    required this.price,
    required this.capacity,
    required this.time,
  });

  @override
  List<Object?> get props => [id, imageAsset, size, price, capacity, time];
}

// ============================= EVENT ====================== //

abstract class SelectTaxiEvent extends Equatable {
  const SelectTaxiEvent();
  @override
  List<Object?> get props => [];
}

class TaxiTabChanged extends SelectTaxiEvent {
  final TaxiTab tab;
  const TaxiTabChanged(this.tab);
  @override
  List<Object?> get props => [tab];
}

class CarSelected extends SelectTaxiEvent {
  final CarOption car;
  const CarSelected(this.car);
  @override
  List<Object?> get props => [car];
}

// ============================= STATE ====================== //
class SelectTaxiState extends Equatable {
  final TaxiTab selectedTab;
  final List<CarOption> carOptions;
  final Map<TaxiTab, CarOption?> selectedCars;

  const SelectTaxiState({
    required this.selectedTab,
    required this.carOptions,
    required this.selectedCars,
  });

  CarOption? get selectedCar => selectedCars[selectedTab];

  SelectTaxiState copyWith({
    TaxiTab? selectedTab,
    List<CarOption>? carOptions,
    Map<TaxiTab, CarOption?>? selectedCars,
  }) {
    return SelectTaxiState(
      selectedTab: selectedTab ?? this.selectedTab,
      carOptions: carOptions ?? this.carOptions,
      selectedCars: selectedCars ?? this.selectedCars,
    );
  }

  @override
  List<Object?> get props => [selectedTab, carOptions, selectedCars];
}

// ============================= BLOC ====================== //
class SelectTaxiBloc extends Bloc<SelectTaxiEvent, SelectTaxiState> {
  SelectTaxiBloc()
      : super(SelectTaxiState(
          selectedTab: TaxiTab.economy,
          carOptions: _mockCarOptions[TaxiTab.economy]!,
          selectedCars: {
            TaxiTab.economy: null,
            TaxiTab.luxury: null,
            TaxiTab.taxicab: null,
          },
        )) {
    on<TaxiTabChanged>((event, emit) {
      emit(state.copyWith(
        selectedTab: event.tab,
        carOptions: _mockCarOptions[event.tab]!,
        // selectedCars remains unchanged
      ));
    });
    on<CarSelected>((event, emit) {
      final updatedSelectedCars =
          Map<TaxiTab, CarOption?>.from(state.selectedCars);
      updatedSelectedCars[state.selectedTab] = event.car;
      emit(state.copyWith(selectedCars: updatedSelectedCars));
    });
  }
}

// Mock Data
final Map<TaxiTab, List<CarOption>> _mockCarOptions = {
  TaxiTab.economy: [
    CarOption(
      id: 'eco1',
      imageAsset: AppAssets.carURL,
      size: 'Small',
      price: ' 20',
      capacity: '2',
      time: '5 min',
    ),
    CarOption(
      id: 'eco2',
      imageAsset: AppAssets.carURL,
      size: 'Medium',
      price: ' 25',
      capacity: '4',
      time: '7 min',
    ),
    CarOption(
      id: 'taxi2',
      imageAsset: AppAssets.carURL,
      size: 'Large',
      price: ' 28',
      capacity: '6',
      time: '8 min',
    ),
  ],
  TaxiTab.luxury: [
    CarOption(
      id: 'eco1',
      imageAsset: AppAssets.carURL,
      size: 'Small',
      price: ' 20',
      capacity: '2',
      time: '5 min',
    ),
    CarOption(
      id: 'eco2',
      imageAsset: AppAssets.carURL,
      size: 'Medium',
      price: ' 25',
      capacity: '4',
      time: '7 min',
    ),
    CarOption(
      id: 'taxi2',
      imageAsset: AppAssets.carURL,
      size: 'Large',
      price: ' 28',
      capacity: '6',
      time: '8 min',
    ),
  ],
  TaxiTab.taxicab: [
    CarOption(
      id: 'eco1',
      imageAsset: AppAssets.carURL,
      size: 'Small',
      price: ' 20',
      capacity: '2',
      time: '5 min',
    ),
    CarOption(
      id: 'eco2',
      imageAsset: AppAssets.carURL,
      size: 'Medium',
      price: ' 25',
      capacity: '4',
      time: '7 min',
    ),
    CarOption(
      id: 'taxi2',
      imageAsset: AppAssets.carURL,
      size: 'Large',
      price: ' 28',
      capacity: '6',
      time: '8 min',
    ),
  ],
};
