import 'package:appdemo/pages/delivery_page.dart';
import 'package:appdemo/pages/food_page.dart';
import 'package:appdemo/pages/user_page.dart';
import 'package:appdemo/providers/navigation_provider.dart';
import 'package:appdemo/widgets/custom_bottom_navigation_bar.dart';
import 'package:appdemo/widgets/custom_bottom_scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'app.demo.org',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _HomePageBody(),
      floatingActionButton: const CustomButtonScanQR(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    final currentIndex = navigationProvider.selectedIndex;

    switch (currentIndex) {
      case 0:
        return const FoodPage();
      case 1:
        return const DeliveryPage();
      case 2:
        return const UserPage();
      default:
        return const HomePage();
    }
  }
}
