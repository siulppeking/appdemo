import 'package:appdemo/pages/delivery_page.dart';
import 'package:appdemo/pages/food_page.dart';
import 'package:appdemo/pages/home_page.dart';
import 'package:appdemo/pages/inicio_page.dart';
import 'package:appdemo/pages/login_page.dart';
import 'package:appdemo/pages/publicacion_page.dart';
import 'package:appdemo/pages/user_page.dart';
import 'package:appdemo/pages/wrapper_page.dart';
import 'package:appdemo/providers/counter_provider.dart';
import 'package:appdemo/providers/login_provider.dart';
import 'package:appdemo/providers/navigation_provider.dart';
import 'package:appdemo/providers/publicacion_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LoginProvider()),
        ChangeNotifierProvider(create: (ctx) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => PublicacionProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'wrapper',
        routes: {
          'wrapper': (ctx) => WrapperPage(),
          'login': (ctx) => LoginPage(),
          'inicio': (ctx) => InicioPage(),
          'publicacion': (ctx) => PublicacionesPage(),
          'home': (ctx) => const HomePage(),
          'food': (ctx) => const FoodPage(),
          'delivery': (ctx) => const DeliveryPage(),
          'user': (ctx) => const UserPage(),
        },
      ),
    );
  }
}
