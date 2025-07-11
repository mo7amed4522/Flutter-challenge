// ============================= EVENT ====================== //

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeTab { ride, delivery, eats, flights }

enum HomeBottomNavTab { home, orders, messages, profile }
// ============================= EVENT ====================== //

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
  @override
  List<Object> get props => [];
}

class ScrollTopBarEvent extends HomeScreenEvent {
  final double offset;

  const ScrollTopBarEvent(this.offset);

  @override
  List<Object> get props => [offset];
}

class HomeTabChangedEvent extends HomeScreenEvent {
  final HomeTab selectedTab;
  const HomeTabChangedEvent(this.selectedTab);

  @override
  List<Object> get props => [selectedTab];
}

class HomeBottomNavChangedEvent extends HomeScreenEvent {
  final HomeBottomNavTab selectedBottomNavTab;
  const HomeBottomNavChangedEvent(this.selectedBottomNavTab);

  @override
  List<Object> get props => [selectedBottomNavTab];
}

class BannerAutoScrollEvent extends HomeScreenEvent {
  const BannerAutoScrollEvent();
  @override
  List<Object> get props => [];
}

// ============================= STATE ====================== //
abstract class HomeScreenState extends Equatable {
  final HomeTab selectedTab;
  final HomeBottomNavTab selectedBottomNavTab;
  final int bannerIndex;
  const HomeScreenState({
    this.selectedTab = HomeTab.ride,
    this.selectedBottomNavTab = HomeBottomNavTab.home,
    this.bannerIndex = 0,
  });
  @override
  List<Object> get props => [selectedTab, selectedBottomNavTab, bannerIndex];
}

class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial(
      {super.selectedTab, super.selectedBottomNavTab, super.bannerIndex});
}

class ExpandedTopBarWidgetState extends HomeScreenState {
  const ExpandedTopBarWidgetState({
    super.selectedTab,
    super.selectedBottomNavTab,
    super.bannerIndex,
  });
  @override
  List<Object> get props => [selectedTab, selectedBottomNavTab, bannerIndex];
}

class CollapsedTopBarWidgetState extends HomeScreenState {
  final bool showSearchBar;
  const CollapsedTopBarWidgetState({
    this.showSearchBar = false,
    super.selectedTab,
    super.selectedBottomNavTab,
    super.bannerIndex,
  });

  @override
  List<Object> get props =>
      [showSearchBar, selectedTab, selectedBottomNavTab, bannerIndex];
}

// ============================= BLOC ====================== //
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(const HomeScreenInitial()) {
    on<ScrollTopBarEvent>((event, emit) {
      if (event.offset > 100) {
        emit(CollapsedTopBarWidgetState(
          showSearchBar: true,
          selectedTab: state.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
        ));
      } else if (event.offset > 0) {
        emit(CollapsedTopBarWidgetState(
          showSearchBar: false,
          selectedTab: state.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
        ));
      } else {
        emit(ExpandedTopBarWidgetState(
          selectedTab: state.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
        ));
      }
    });
    on<HomeTabChangedEvent>((event, emit) {
      if (state is CollapsedTopBarWidgetState) {
        emit(CollapsedTopBarWidgetState(
          showSearchBar: (state as CollapsedTopBarWidgetState).showSearchBar,
          selectedTab: event.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
        ));
      } else if (state is ExpandedTopBarWidgetState) {
        emit(ExpandedTopBarWidgetState(
          selectedTab: event.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
        ));
      } else {
        emit(HomeScreenInitial(
          selectedTab: event.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
        ));
      }
    });
    on<HomeBottomNavChangedEvent>((event, emit) {
      if (state is CollapsedTopBarWidgetState) {
        emit(CollapsedTopBarWidgetState(
          showSearchBar: (state as CollapsedTopBarWidgetState).showSearchBar,
          selectedTab: state.selectedTab,
          selectedBottomNavTab: event.selectedBottomNavTab,
        ));
      } else if (state is ExpandedTopBarWidgetState) {
        emit(ExpandedTopBarWidgetState(
          selectedTab: state.selectedTab,
          selectedBottomNavTab: event.selectedBottomNavTab,
        ));
      } else {
        emit(HomeScreenInitial(
          selectedTab: state.selectedTab,
          selectedBottomNavTab: event.selectedBottomNavTab,
        ));
      }
    });
    on<BannerAutoScrollEvent>((event, emit) {
      const bannerCount = 3;
      final nextIndex = (state.bannerIndex + 1) % bannerCount;
      if (state is CollapsedTopBarWidgetState) {
        emit(CollapsedTopBarWidgetState(
          showSearchBar: (state as CollapsedTopBarWidgetState).showSearchBar,
          selectedTab: state.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
          bannerIndex: nextIndex,
        ));
      } else if (state is ExpandedTopBarWidgetState) {
        emit(ExpandedTopBarWidgetState(
          selectedTab: state.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
          bannerIndex: nextIndex,
        ));
      } else {
        emit(HomeScreenInitial(
          selectedTab: state.selectedTab,
          selectedBottomNavTab: state.selectedBottomNavTab,
          bannerIndex: nextIndex,
        ));
      }
    });
  }
}
