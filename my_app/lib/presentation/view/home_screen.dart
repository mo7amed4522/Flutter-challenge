// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/home_screen_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../core/assets/app_assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        final brightness = MediaQuery.of(context).platformBrightness;
        final isIOS = Platform.isIOS;

        Widget content = Column(
          children: [
            _CustomAppBar(),
            Expanded(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    _NavigationTabs(selectedTab: state.selectedTab),
                    const SizedBox(height: 10),
                    _BannerListView(),
                    const SizedBox(height: 26),
                    _CommunitySection(),
                    const SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ],
        );

        return isIOS
            ? CupertinoPageScaffold(
                backgroundColor: brightness == Brightness.dark
                    ? AppTheme.cupertinoDarkTheme.scaffoldBackgroundColor
                    : AppTheme.cupertinoLightTheme.scaffoldBackgroundColor,
                navigationBar: null,
                child: Stack(
                  children: [
                    content,
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _CustomBottomNavBar(
                          selectedBottomNavTab: state.selectedBottomNavTab),
                    ),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Stack(
                  children: [
                    content,
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _CustomBottomNavBar(
                          selectedBottomNavTab: state.selectedBottomNavTab),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 400;
    final padding = isSmallScreen ? 12.0 : 20.0;
    final textFieldHeight = isSmallScreen ? 40.0 : 48.0;

    return Container(
      height: 205,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(padding, padding, padding, padding / 2),
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 17,
          ),
          Row(
            children: [
              Text(
                'Hi, Micheal',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: isIOS
                      ? CupertinoTheme.of(context).barBackgroundColor
                      : Theme.of(context).colorScheme.surfaceContainerLow,
                  fontFamily: 'SFProDisplay',
                ),
              ),
              Spacer(),
              TextButton(
                  onPressed: () => context.push("/select-taxi-screen"),
                  child: Text(
                    "Go To Map",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
          SizedBox(height: isSmallScreen ? 10 : 20),
          isIOS
              ? SizedBox(
                  height: textFieldHeight,
                  child: CupertinoTextField(
                    placeholder: 'How can we serve you today ?',
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Icon(CupertinoIcons.search, color: Colors.grey),
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                      fontFamily: 'SFProDisplay',
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    minLines: 1,
                    maxLines: 1,
                    expands: false,
                    textInputAction: TextInputAction.search,
                    placeholderStyle: TextStyle(color: Colors.grey.shade500),
                    autofocus: true,
                    prefixMode: OverlayVisibilityMode.never,
                    suffixMode: OverlayVisibilityMode.always,
                  ),
                )
              : SizedBox(
                  height: textFieldHeight,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'How can we serve you today?',
                      prefixIcon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.onPrimary),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
        ],
      ),
    );
  }
}

class _NavigationTabs extends StatelessWidget {
  final HomeTab selectedTab;

  const _NavigationTabs({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final tabLabels = const [
      'Ride',
      'Delivery',
      'Eats',
      'Flights',
    ];
    final tabs = HomeTab.values;
    final isSmallScreen = MediaQuery.of(context).size.width < 400;
    final tabWidth = isSmallScreen ? 90.0 : 100.0;

    return Container(
      height: 56,
      color: isIOS
          ? const Color.fromARGB(255, 28, 36, 62)
          : Theme.of(context).colorScheme.onPrimary,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            final isSelected = selectedTab == tab;
            return GestureDetector(
              onTap: () {
                context.read<HomeScreenBloc>().add(HomeTabChangedEvent(tab));
              },
              child: Container(
                width: tabWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 4 : 8, vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isIOS
                      ? const Color.fromARGB(255, 28, 36, 62)
                      : Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    tabLabels[index],
                    style: TextStyle(
                      color: isIOS
                          ? isSelected
                              ? Colors.white
                              : Colors.white38
                          : isSelected
                              ? Theme.of(context).tabBarTheme.indicatorColor
                              : Theme.of(context)
                                  .tabBarTheme
                                  .unselectedLabelColor,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: isSmallScreen ? 14 : 16,
                      fontFamily: 'SFProDisplay',
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _BannerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 400;
    final bannerHeight = isSmallScreen ? 90.0 : 200.0;
    final bannerWidth = isSmallScreen ? 220.0 : 300.0;
    final bannerRadius = 16.0;
    final bannerCount = 3;

    return SizedBox(
      height: bannerHeight + 24,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: bannerCount,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(bannerRadius),
            child: Image.asset(
              AppAssets.bannerImageURL,
              width: bannerWidth,
              height: bannerHeight,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}

class _CommunitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 400;
    final bannerWidth = isSmallScreen ? 220.0 : 300.0;
    final cardWidth = bannerWidth / 2;
    final cardHeight = isSmallScreen ? 170.0 : 200.0;
    final cardRadius = 18.0;
    final imageHeight = isSmallScreen ? 80.0 : 100.0;
    final events = [
      {
        'image': AppAssets.imageseURL,
        'date': 'Sun, May 3',
        'title': 'Carmicheal Farmer Market',
      },
      {
        'image': AppAssets.images1URL,
        'date': 'Sat, May 10',
        'title': 'Concert at the Park',
      },
    ];
    final cards = List.generate(4, (i) => events[i % 2]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            "What's going on in your community ?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final card = cards[index];
              return Container(
                width: cardWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(cardRadius)),
                      child: Image.asset(
                        card['image']!,
                        width: cardWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card['date']!,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 10 : 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            card['title']!,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final HomeBottomNavTab selectedBottomNavTab;
  const _CustomBottomNavBar({required this.selectedBottomNavTab});
  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final items = const [
      {'icon': Icons.home, 'label': 'HOME'},
      {'icon': Icons.shopping_cart, 'label': 'ORDERS'},
      {'icon': Icons.message, 'label': 'MESSAGES'},
      {'icon': null, 'label': 'PROFILE'},
    ];
    final cupertinoIcons = const [
      CupertinoIcons.home,
      CupertinoIcons.cart,
      CupertinoIcons.chat_bubble_2,
      null,
    ];
    HomeBottomNavTab _tabFromIndex(int index) {
      switch (index) {
        case 0:
          return HomeBottomNavTab.home;
        case 1:
          return HomeBottomNavTab.orders;
        case 2:
          return HomeBottomNavTab.messages;
        case 3:
          return HomeBottomNavTab.profile;
        default:
          return HomeBottomNavTab.home;
      }
    }

    int _indexFromTab(HomeBottomNavTab tab) => tab.index;

    if (isIOS) {
      return CupertinoTabBar(
        border: Border(top: BorderSide(width: 0, color: Colors.transparent)),
        items: List.generate(
          4,
          (i) => BottomNavigationBarItem(
            icon: i == 3
                ? ClipOval(
                    child: Image.asset(
                      AppAssets.persionURL,
                      width: 26,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(cupertinoIcons[i]),
            label: items[i]['label'] as String,
          ),
        ),
        currentIndex: _indexFromTab(selectedBottomNavTab),
        onTap: (index) {
          context
              .read<HomeScreenBloc>()
              .add(HomeBottomNavChangedEvent(_tabFromIndex(index)));
        },
        backgroundColor: Colors.transparent,
        activeColor: CupertinoTheme.of(context).primaryColor,
        inactiveColor: CupertinoTheme.of(context).barBackgroundColor,
      );
    }
    return BottomNavigationBar(
      items: List.generate(
        4,
        (i) => BottomNavigationBarItem(
          icon: i == 3
              ? ClipOval(
                  child: Image.asset(
                    AppAssets.persionURL,
                    width: 26,
                    height: 26,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(items[i]['icon'] as IconData),
          label: items[i]['label'] as String,
        ),
      ),
      currentIndex: _indexFromTab(selectedBottomNavTab),
      onTap: (index) {
        context
            .read<HomeScreenBloc>()
            .add(HomeBottomNavChangedEvent(_tabFromIndex(index)));
      },
      backgroundColor: Colors.transparent,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
      type: BottomNavigationBarType.fixed,
    );
  }
}
