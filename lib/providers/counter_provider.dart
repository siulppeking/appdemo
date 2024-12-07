import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Notifica a los widgets que escuchan.
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }

   void reset() {
    _counter = 0;
    notifyListeners();
  }
}
