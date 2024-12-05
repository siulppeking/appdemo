import 'package:appdemo/pages/delivery_page.dart';
import 'package:appdemo/pages/food_page.dart';
import 'package:appdemo/pages/home_page.dart';
import 'package:appdemo/pages/user_page.dart';
import 'package:appdemo/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => NavigationProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (ctx) => const HomePage(),
          'food': (ctx) => const FoodPage(),
          'delivery': (ctx) => const DeliveryPage(),
          'user': (ctx) => const UserPage(),
        },
      ),
    );
  }
}
