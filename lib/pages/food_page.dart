import 'package:appdemo/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Usando context.watch para acceder al estado y escuchar cambios.
    final counter = context.watch<CounterProvider>().counter;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Contador:', style: TextStyle(fontSize: 24)),
          Text(
            '$counter',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => context.read<CounterProvider>().increment(),
                child: const Text('+'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => context.read<CounterProvider>().reset(),
                child: const Text('Reset'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => context.read<CounterProvider>().decrement(),
                child: const Text('-'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
