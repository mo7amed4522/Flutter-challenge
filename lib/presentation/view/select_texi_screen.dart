// ignore_for_file: deprecated_member_use

import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/assets/app_assets.dart';
import '../bloc/select_taxi_bloc.dart';

class SelectTexiScreen extends StatelessWidget {
  const SelectTexiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    return BlocProvider(
      create: (_) => SelectTaxiBloc(),
      child: isIOS ? const _SelectTaxiCupertino() : const _SelectTaxiMaterial(),
    );
  }
}

class _SelectTaxiCupertino extends StatelessWidget {
  const _SelectTaxiCupertino();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Select your ridy'),
      ),
      child: SafeArea(
        child: _SelectTaxiContent(isIOS: true, width: width, height: height),
      ),
    );
  }
}

class _SelectTaxiMaterial extends StatelessWidget {
  const _SelectTaxiMaterial();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your ridy'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: _SelectTaxiContent(isIOS: false, width: width, height: height),
      ),
    );
  }
}

class _SelectTaxiContent extends StatelessWidget {
  final bool isIOS;
  final double width;
  final double height;
  const _SelectTaxiContent(
      {required this.isIOS, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectTaxiBloc, SelectTaxiState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.mapURL),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                'Select your ridy',
                style: TextStyle(
                  fontSize: width < 400 ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: isIOS ? CupertinoColors.black : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _TaxiTabs(isIOS: isIOS, selectedTab: state.selectedTab),
            const SizedBox(height: 12),
            SizedBox(
              height: 170,
              child: Builder(
                builder: (context) {
                  // Always show 3 cards: Small, Medium, Large
                  final sizes = ['Small', 'Medium', 'Large'];
                  final carOptions = state.carOptions;
                  final selectedCarId =
                      state.selectedCars[state.selectedTab]?.id;
                  List<Widget> cards = [];
                  for (final size in sizes) {
                    final car = carOptions.firstWhere(
                      (c) => c.size.toLowerCase() == size.toLowerCase(),
                      orElse: () => CarOption(
                        id: 'placeholder_${state.selectedTab}_$size',
                        imageAsset: '',
                        size: size,
                        price: '-',
                        capacity: '-',
                        time: '-',
                      ),
                    );
                    final isSelected = selectedCarId == car.id;
                    cards.add(
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _CarOptionCard(
                          car: car,
                          isSelected: isSelected,
                          tab: state.selectedTab,
                          isIOS: isIOS,
                          onTap: () => context
                              .read<SelectTaxiBloc>()
                              .add(CarSelected(car)),
                        ),
                      ),
                    );
                  }
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: cards,
                  );
                },
              ),
            ),
            Spacer(),
            _PaymentBookingSection(isIOS: isIOS, width: width),
          ],
        );
      },
    );
  }
}

class _TaxiTabs extends StatelessWidget {
  final bool isIOS;
  final TaxiTab selectedTab;
  const _TaxiTabs({required this.isIOS, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    final tabLabels = const ['Economy', 'Luxury', 'Taxicab'];
    final tabs = TaxiTab.values;
    final activeColor = const Color(0xFF009688);
    final inactiveTextColor =
        isIOS ? CupertinoColors.inactiveGray : Colors.grey[700];
    final underlineHeight = 3.0;
    final underlineRadius = 2.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (i) {
        final isActive = selectedTab == tabs[i];
        return Expanded(
          child: GestureDetector(
            onTap: () =>
                context.read<SelectTaxiBloc>().add(TaxiTabChanged(tabs[i])),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    tabLabels[i],
                    style: TextStyle(
                      color: isActive ? activeColor : inactiveTextColor,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: underlineHeight,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: isActive ? activeColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(underlineRadius),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _CarOptionCard extends StatelessWidget {
  final CarOption car;
  final bool isSelected;
  final TaxiTab tab;
  final bool isIOS;
  final VoidCallback? onTap;
  const _CarOptionCard({
    required this.car,
    required this.isSelected,
    required this.tab,
    required this.isIOS,
    this.onTap,
  });

  Color _selectedColor() {
    switch (tab) {
      case TaxiTab.economy:
        return const Color(0xFFB2DFDB);
      case TaxiTab.luxury:
        return const Color(0xFF81D4FA);
      case TaxiTab.taxicab:
        return const Color(0xFFFFF3E0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = isSelected ? _selectedColor() : Colors.white;
    final borderColor =
        isSelected ? const Color(0xFF009688) : Colors.grey[300]!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: car.imageAsset.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          car.imageAsset,
                          width: 64,
                          height: 48,
                          fit: BoxFit.fill,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.directions_car, size: 48),
                        ),
                      )
                    : Container(
                        width: 64,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.directions_car,
                            size: 32, color: Colors.grey),
                      ),
              ),
              const SizedBox(height: 9),
              // Size
              Text(
                car.size,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 70, 69, 69),
                ),
              ),
              const SizedBox(height: 4),
              // Price
              Text(
                car.price == '-' ? 'Price: -' : 'Price: ${car.price} USD',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    car.capacity == '-' ? '-' : car.capacity,
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const Spacer(),
                  Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    car.time == '-' ? '-' : car.time,
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentBookingSection extends StatelessWidget {
  final bool isIOS;
  final double width;
  const _PaymentBookingSection({required this.isIOS, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
      decoration: BoxDecoration(
        color: isIOS ? CupertinoColors.systemGrey6 : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(isIOS ? CupertinoIcons.creditcard : Icons.credit_card,
                      color: Colors.black, size: 22),
                  const SizedBox(width: 8),
                  const Text(
                    'VISA **7539',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                      isIOS
                          ? CupertinoIcons.chevron_right
                          : Icons.arrow_forward_ios,
                      color: Colors.grey[500],
                      size: 18),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(isIOS ? CupertinoIcons.phone : Icons.phone,
                            color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text('Now', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(isIOS
                      ? CupertinoIcons.chevron_right
                      : Icons.arrow_forward_ios),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: isIOS
                ? CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(30),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: const Text('Book this Car',
                        style: TextStyle(fontSize: 17)),
                    onPressed: () {},
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Book this Car',
                        style: TextStyle(fontSize: 17)),
                  ),
          ),
        ],
      ),
    );
  }
}
