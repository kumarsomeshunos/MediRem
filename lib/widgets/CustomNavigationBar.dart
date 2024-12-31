import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medirem/widgets/CardsList.dart';

import 'MedicineData.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> currentDynamicData = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// Initialize data and start periodic updates
  void _initializeData() {
    _updateDynamicData();
    _startTimer();
  }

  /// Start a timer to refresh data every minute
  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _updateDynamicData();
    });
  }

  /// Update the dynamic data and refresh the UI
  void _updateDynamicData() {
    setState(() {
      currentDynamicData = MedicineData.getDynamicCardDataWithOnlyCurrentTime();
    });
  }

  /// Manual refresh triggered by the user
  void _manualRefresh() {
    _updateDynamicData();
    _showSnackBar('Data refreshed successfully!');
  }

  /// Show a snack bar message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'MediRem',
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 28.0),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _manualRefresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  /// Builds the bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedIndex: _selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.list),
          icon: Icon(Icons.list_outlined),
          label: 'List',
        ),
      ],
    );
  }

  /// Builds the body of the screen based on the selected index
  Widget _buildBody() {
    final pages = [
      _buildHomePage(),
      _buildListPage(),
    ];
    return pages[_selectedIndex];
  }

  /// Builds the Home page
  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          currentDynamicData.isEmpty
              ? const Center(
                  child: Text(
                    'No medicines to take at this hour.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )
              : const Text(
                  'Take Now',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 18.0,
                  ),
                ),
          const SizedBox(height: 16),
          Expanded(
            child: CardsList(
              cardData: currentDynamicData,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the List page
  Widget _buildListPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'List of all eye drops',
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: CardsList(
              cardData: MedicineData.getAllCardData(),
            ),
          ),
        ],
      ),
    );
  }
}
