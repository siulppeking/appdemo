import 'package:appdemo/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    final currentIndex = navigationProvider.selectedIndex;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      elevation: 0,
      onTap: (index) => navigationProvider.selectedIndex = index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.food_bank),
          label: 'Food',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.motorcycle),
          label: 'Delivery',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'User',
        ),
      ],
    );
  }
}
